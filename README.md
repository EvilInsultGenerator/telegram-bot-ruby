# Evil Insult Generator Ruby Telegram Bot
[![Build Status](https://travis-ci.org/EvilInsultGenerator/telegram-bot-ruby.svg?branch=master)](https://travis-ci.org/EvilInsultGenerator/telegram-bot-ruby)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/323a74806cf546b4a8b9c473ed224d2d)](https://www.codacy.com/app/EvilInsultGenerator/telegram-bot-ruby?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=EvilInsultGenerator/telegram-bot-ruby&amp;utm_campaign=Badge_Grade)
[![Website](https://img.shields.io/website-up-down-green-red/https/shields.io.svg)](https://evilinsult.com)

Evil Insult Generator's goal is to offer the most evil insults. Please help us to reach this honorable purpose by submitting insults via mail.

![Evil Insult Generator Icon](https://cloud.githubusercontent.com/assets/22981912/19600664/5521d010-97a6-11e6-9f67-fec931b199d7.png)

### Installation

Clone this repository to your local machine
`git clone https://github.com/EvilInsultGenerator/telegram-bot-ruby.git`
For the first you need to install gems required to start a bot:
`bundle install`
Then you need to create `secrets.yml` where your bot unique tokens will be stored and `database.yml` where database credentials will be stored.
```ruby
#config/database.yml
adapter: postgresql
database: *your_DB_name*
encoding: unicode
pool: 5
timeout: 5000
```
```ruby
#config/secrets.yml
telegram_bot_token: *your_bot_token*
botan_token: *your_botan_token*
```
Then you need to fill your Telegram bot unique token to the `secrets.yml` file and your database credentials to `database.yml`.

After this you need to create and migrate your database:
`rake db:create db:migrate`
Great!
Now you can easily start your bot just by running this command:
`bin/bot`

__Try out [@EIG_bot](https://telegram.me/@EIG_bot).__

### Contact

We love to get in touch with you. Feel welcome to email your questions and feedback to [marvin@evilinsult.com](mailto:marvin@evilinsult.com).

### License
> This is free and unencumbered software released into the public domain.
> 
> Anyone is free to copy, modify, publish, use, compile, sell, or
> distribute this software, either in source code form or as a compiled
> binary, for any purpose, commercial or non-commercial, and by any
> means.
> 
> In jurisdictions that recognize copyright laws, the author or authors
> of this software dedicate any and all copyright interest in the
> software to the public domain. We make this dedication for the benefit
> of the public at large and to the detriment of our heirs and
> successors. We intend this dedication to be an overt act of
> relinquishment in perpetuity of all present and future rights to this
> software under copyright law.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
> IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> OTHER DEALINGS IN THE SOFTWARE.
> 
> For more information, please refer to <http://unlicense.org/>

### Screenshots
![Evil Insult Generator Ruby Telegram Bot Screenshot](https://cloud.githubusercontent.com/assets/23016876/19629005/3edce1c0-996b-11e6-8beb-d19453826a1c.png)
