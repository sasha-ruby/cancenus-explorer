# Global options
options(stringsAsFactors = F)
Sys.setenv(TZ = "America/Vancouver")

# cancensus global config
options(cancensus.api_key = "my.census.mapper.api.key")
options(cancensus.cache_path = here::here("cache"))
