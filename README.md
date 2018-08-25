<p align="center">
    <img src="http://sargantanacode.es/sargantanacode.png" alt="SargantanaCode" />
</p>

<p align="center">
    <a href="https://travis-ci.org/sargantanacode/sargantanacode/">
        <img src="https://travis-ci.org/sargantanacode/sargantanacode.svg?branch=master" alt="Build Status"/>
    </a>
</p>

# About
This is the public sourcecode for [SargantanaCode](http://sargantanacode.es)'s project. This application has been developed from scratch using the [Ruby on Rails](https://rubyonrails.org/) framework.

# Requirements
* [Ruby](https://www.ruby-lang.org) 2.4 or higher.
* [Bundler](https://bundler.io/).
* [MariaDB](https://mariadb.org/) or [MySQL](https://www.mysql.com/) (this app has not been tested with other DBMS, so we don't offer support for them).
* [Node.js](https://nodejs.org) and [Yarn](https://yarnpkg.com) for the front-end dependencies ([webpacker](https://github.com/rails/webpacker)).
* [ChromeDriver](http://chromedriver.chromium.org/) only for Feature Testing purposes.

# Installation
First, you need to clone this repository and install its dependencies:
```console
$ git clone https://github.com/sargantanacode/sargantanacode
$ cd sargantanacode
$ bundle install
$ yarn install
$ bin/webpack
```
Then you have to edit the app settings and fill in the required data:
```console
$ mv .env.example .env
$ vim .env
```
Now it's time to create the database:
```console
$ rails db:create
$ rails db:migrate
```
At this point you can start a development server by typing `rails s` and just when you visit http://localhost:3000 a form will appear from which you can create the first user with admin privileges.

By default the mailing is configured as SMTP (and you can check it in the .env file); if this method doesn't suit your needs, you'll always be able to customize the environments from the *config/environments* directory.

# License
[GNU GPL v3](LICENSE.txt)

    This program is free software: you can redistribute it and/or modify it under
    the terms of the GNU General Public License as published by the Free Software
    Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along with
    this program.  If not, see <http://www.gnu.org/licenses/>.
