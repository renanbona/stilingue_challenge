##### Prerequisites

The setups steps expect following tools installed on the system.

- Ruby [2.5.3]
- Rails [5.2.2]
- Node
- Postgresql

##### 1. Check out the repository

```bash
git clone git@github.com:renanbona/stilingue_challenge.git
```

##### 2. Configure database file

Copy the sample .database.yml.sample file and edit with your credentials.

```bash
cp config/database.yml.sample config/database.yml
```

##### 3. Install the gems

```bash
bundle install
```

##### 4. Install all js dependencies by running

```bash
yarn install
```

##### 5. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rails db:setup
```

##### 6. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

##### 7. Tests

You can start run the tests with

```ruby
bundle exec rspec
```
