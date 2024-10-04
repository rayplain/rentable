## Table of Contents

- [Database](#database)
- [Development](#development)
- [Testing](#testing)

### Create and Setup the Database


```sh
rake db:create
rake db:migrate
rake db:seed
```

### Start the Server

```sh
bundle exec foreman start
```
## Testing

I used rspec so the usual
```sh
bundle exec rspec
```
Will work. Most importantly really is the integration tests. 


