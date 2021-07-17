# MSM QUERIES

## Target

Here is our target:

[https://msm-queries.matchthetarget.com/](https://msm-queries.matchthetarget.com/)

## Objective

In this project, we'll finally use our first database tables! Mostly, we'll practice using `.where` and other **ActiveRecord** methods. `ActiveRecord` is the name of the class that Rails provides from which we inherit lots of database-related goodies. (There is an [the ActiveRecord Chapter](https://chapters.firstdraft.com/chapters/770) also, which you should read through after watching the video paired with this project.)

We're going to practice in the context of our familiar movie-related domain — Directors, Movies, Characters, and Actors. As you're watching the video, you'll probably (hopefully) have lots of questions — **write them down** for us to discuss the next time we're together!

## Two new visual development URLs

We have two new visual development tools that we can visit, in addition to `/git`:

 - `/rails/info`: shows all visitable routes in the applications
 - `/rails/db`: shows a visual interface for the database

## Our database

If you visit `/rails/db`, you'll see that in this project, I've already created our database and added four tables: the familiar directors, movies, characters, and actors. (In future projects, you'll learn how to add your own tables with whatever columns you want; it's just one command-line command per table.)

### SQL

Normally, to add some records into a relational database, we'd have to learn Structured Query Language (SQL). Here are some examples of SQL, if you want to give it a try in the SQL Editor.

Adding a director:

```sql
INSERT INTO "directors" ("name", "dob", "bio", "image", "created_at", "updated_at")
VALUES ("Greta Gerwig", "1983-08-04", "Greta Celeste Gerwig /ˈɡɜːrwɪɡ/; born August 4, 1983) is an American actress and filmmaker. She first garnered attention after working on and appearing in several mumblecore films. Between 2006 and 2009, she appeared in a number of films by Joe Swanberg, some of which she co-wrote or co-directed, including Hannah Takes the Stairs 2007) and Nights and Weekends 2008).", "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/Greta_Gerwig_Berlinale_2018.jpg/330px-Greta_Gerwig_Berlinale_2018.jpg", "2020-05-19 17:47:04.103354", "2020-05-19 17:47:04.103354")
```

Adding a movie:

```sql
INSERT INTO "movies" ("title", "year", "duration", "description", "image", "director_id", "created_at", "updated_at")
VALUES ("Little Women", 2019, 135, "Jo March reflects back and forth on her life, telling the beloved story of the March sisters - four young women, each determined to live life on her own terms.", "https://upload.wikimedia.org/wikipedia/en/9/9d/Little_Women_%282019_film%29.jpeg", 35, "2020-05-19 17:31:22.333798", "2020-05-19 17:31:22.333798")
```

Go ahead and paste these in exactly as-is if you'd like to add a row to each table.

Relational databases are extremely powerful, and SQL is a very sharp tool. But, not a lot of fun to type out by hand.

Wouldn't it be nicer to write Ruby?

## Add Ruby classes

Let's create some Ruby classes that will help us interact with our database. In the `app/models` folder, create the following four files:

```ruby
# app/models/actor.rb
class Actor < ApplicationRecord
end
```

```ruby
# app/models/character.rb
class Character < ApplicationRecord
end
```

```ruby
# app/models/director.rb
class Director < ApplicationRecord
end
```

```ruby
# app/models/movie.rb
class Movie < ApplicationRecord
end
```

Now, let's try these Ruby classes out. We could create a rake task, but a quicker way to run one-line Ruby programs is to use the `rails console`. Run that command at a Terminal prompt, and you'll get a REPL where you can run Ruby interactively.

## Important notes about `rails console`

 1. Sometimes when the output of a Ruby expression is very long, `rails console` is going to paginate it for you. You will have a `:` prompt when this is true, and you can hit <kbd>return</kbd> to scroll through line by line, or <kbd>space</kbd> to scroll through page by page.

    When you reach the end of the output, you'll see `(END)`.

    **To get back to the regular prompt so that you can enter your next command, just hit q at any time.**

 2. If you are in `rails console` and then make a change to a model (for example, you define a new method or fix a syntax error), then, annoyingly, **you have to `exit` and then start a new `rails console`** to pick up the new logic. Or, you can use the `reload!` method.

## Exploring the tables

Open a Terminal tab, launch a `rails console` session, and then try the following:

```ruby
Director.count
Movie.count
Character.count
Actor.count
```

You'll see that the `.count` method already works, even though we didn't define it; but right now there are no rows in any of the tables. You can see what columns are in each table by:

 - Typing just the class name into `rails console`, e.g.

    ```
    [2] pry(main)> Character
    => Character(id: integer, movie_id: integer, actor_id: integer, name: string, created_at: datetime, updated_at: datetime)
    ```

 - Looking at the comments at the top of the model file, e.g. `app/models/movie.rb`. (These comments are auto-generated and kept up to date by the excellent [annotate gem](https://github.com/ctran/annotate_models).)

## CRUD some records

Okay, now that we have ActiveRecord Ruby classes to translate for us, we can generate the same SQL as above (better actually) by just using familiar Ruby methods. Let's [create some records](https://chapters.firstdraft.com/chapters/770#new):

```ruby
d = Director.new
d.name = "Greta Gerwig"
d.dob = "August 4, 1983"
```

So far it's just like [any other Ruby class we've defined](https://chapters.firstdraft.com/chapters/769#our-own-classes), but now we can also do...

```ruby
d.save
```

And voila! ActiveRecord generates a fully-formed SQL statement to transact with the database.

You can check out your newly saved director:

```ruby
Director.all.at(-1)
```

or, for short,

```ruby
Director.last
```

Similarly, we can add a new movie (this assumes it is directed by someone who was assigned the ID number `42` in the directors table):

```ruby
m = Movie.new
m.title = "Little Women"
m.year = 2019
m.duration = 135
m.director_id = 42
m.save
```

Add a couple more directors and movies, an actor and a character, to get some practice instantiating objects, assigning values to their attributes, and saving them.

## Hydrate with sample data

We could enter a bunch of movies — perhaps even [the entire IMDB Top 250](https://www.imdb.com/chart/top) — manually in `rails console` this way; adding directors and actors first, then adding movies, and finally adding characters to join movies and actors.

Go ahead and add the IMDB Top 250 by hand with `.new`, `.save`, etc..... just kidding! That would take forever. In the real world, _someone_ would initially have to add all of our data, whether it's us, or our employees, or our users (through forms in their browser, obviously, not through `rails console`).

But, to make life easy for developers working on this app, I've included a program that will populate your tables for you quickly. I named the program `sample_data`, and you can run it from the command prompt with `rails sample_data`.

We'll talk more about how to write these programs in a later lesson, but they are just Ruby scripts like the ones you've written before. In this case, the Ruby script automates what you've been doing in `rails console` — using `Director`, `Movie`, `Character`, and `Actor` to CRUD records.

When you run `rails sample_data`, you should see output similar to this:

```bash
There are 34 directors in the database
There are 50 movies in the database
There are 652 actors in the database
There are 722 characters in the database
```

You can verify this yourself by `.count`ing each table in `rails console`.

## Target

Here is our target:

[https://msm-queries.matchthetarget.com/](https://msm-queries.matchthetarget.com/)

## Tasks

### Finding a movie by title

How many years ago was "Casablanca" released?

 - Use the [`.where` method](https://chapters.firstdraft.com/chapters/770#where). It is everything.
 - Remember that [`.where` always returns a collection, not a single row](https://chapters.firstdraft.com/chapters/770#where-always-returns-a-collection-not-a-single-row).
 - Calculate the value dynamically (using e.g. `Time.now.year`), so that the number is always up to date.

### Other queries

 - How many movies in our table are from [before](https://chapters.firstdraft.com/chapters/770#less-than-or-greater-than) the year 2000?
    - Displays the titles and years of the films.
 - Who is the youngest director in our table?
    - Display the date of birth of the director. (Remember you can call `.strftime("")` on `Time`, `Date`, and `DateTime`s to format them. Tools like [strftime.net](http://strftime.net/) and [For a Good Strftime](https://www.foragoodstrftime.com/) exist to help compose the formatting string argument.)
 - How many directors in our table are less than 55 years old?
    - Display their names and dates of birth.
 - How many films in our table were directed by Francis Ford Coppola?
    - Display the titles and years of the films.
 - How many films did Morgan Freeman appear in?
    - Display the titles and years of the films.

## Drive the view templates with the data from the database

Now that we've gotten our feet wet with using ActiveRecord to interact with the database, let's put it together with everything we've learned in the past — RCAV, `params`, HTML, etc — to make our app match the target.

## Specs
<details>
  <summary>Click here to see names of each test</summary>

<li>/directors/youngest displays only the youngest directors name </li>

<li>/directors/eldest displays only the eldest directors name </li>

<li>/directors lists the names of each Director record in the database </li>

<li>/directors has a 'Show details' link to the details page of each director </li>

<li>/directors/[DIRECTOR ID] displays the name of a specified Director record </li>

<li>/directors/[DIRECTOR ID] displays the dob of a specified Director record </li>

<li>/directors/[DIRECTOR ID] displays the bio of a specified Director record </li>

<li>/directors/[DIRECTOR ID] displays the names of the movies that were directed by the Director </li>

<li>/directors/[DIRECTOR ID] has a 'Show details' link to the details page of each Movie in the Director's filmography </li>

<li>/movies lists the titles of each Movie record in the database </li>

<li>/movies displays the name of the Director who directed the Movie </li>

<li>/movies has a 'Show details' link to the details page of each Movie </li>

<li>/movies/[MOVIE ID] displays the name of the Director who directed the Movie </li>

<li>/movies/[MOVIE ID] displays the title of the Movie </li>

<li>/movies/[MOVIE ID] displays the description of the Movie </li>

<li>/movies/[MOVIE ID] displays the year of the Movie </li>

<li>/movies/[MOVIE ID] displays the duration of the Movie </li>

<li>/actors lists the names of each Actor record in the Actor table </li>

<li>/actors has a 'Show details' link to the details page of each Actor </li>

<li>/actors/ACTOR ID] displays the name of the Actor record </li>

<li>/actors/ACTOR ID] displays the dob of the Actor record </li>

<li>/actors/ACTOR ID] displays the names of every Character the Actor has played </li>

<li>/actors/ACTOR ID] displays the names of the Directors of each Movie the Actor has starred in </li>

<li>Movie has a class defined in app/models/ </li>

<li>Director has a class defined in app/models/ </li>

<li>Actor has a class defined in app/models/ </li>

<li>Character has a class defined in app/models/ </li>

</details>