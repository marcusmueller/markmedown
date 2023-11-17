# DEMO 2

### Code listing

```c++
#include <algorithm>
#include <cmath>
#include <complex>
#include <cstddef>
#include <filesystem>
#include <fstream>
#include <string_view>
#include <vector>

#include <fmt/format.h>
#include <fmt/ranges.h>

using sample_t = std::complex<float>;
using power_t = float;
constexpr std::size_t read_block_size = 1 << 16;

int main(int argc, char *argv[]) {
  // expect exactly one argument, a file name
  if (argc != 2) {
    fmt::print(stderr, "Usage: {} FILE_NAME", argv[0]);
    return -1;
  }
  // just for convenience; we could as well just use `argv[1]` throughout the
  // code
  std::string_view filename(argv[1]);

  // check whether file exists
  if (!std::filesystem::exists(filename.data())) {
    fmt::print(stderr, "file '{:s}' not found\n", filename);
    return -2;
  }

  // calculate how many samples to read
  auto file_size = std::filesystem::file_size(std::filesystem::path(filename));
  auto samples_to_read = file_size / sizeof(sample_t);

  // construct and reserve container for resulting powers
  std::vector<power_t> powers;
  powers.reserve(samples_to_read);

  std::ifstream input_file(filename.data(), std::ios_base::binary);
  if (!input_file) {
    fmt::print(stderr, "error opening '{:s}'\n", filename);
    return -3;
  }

  // construct and reserve container for read samples
  // if read_block_size == 0, then read the whole file at once
  std::vector<sample_t> samples;
  if (read_block_size)
    samples.resize(read_block_size);
  else
    samples.resize(samples_to_read);

  fmt::print(stderr, "Reading {:d} samples…\n", samples_to_read);
  while (samples_to_read) {
    auto read_now = std::min(samples_to_read, samples.size());
    input_file.read(reinterpret_cast<char *>(samples.data()),
                    read_now * sizeof(sample_t));
    for (size_t idx = 0; idx < read_now; ++idx) {
      auto magnitude = std::abs(samples[idx]);
      powers.push_back(magnitude * magnitude);
    }
    samples_to_read -= read_now;
  }

  // we're not actually doing anything with the data. Let's print it!
  fmt::print("Power\n{}\n", fmt::join(powers, "\n"));
}
```
