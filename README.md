# PerqaraApi

This project is a CRUD API for a simple blogging platform, built with Elixir, Phoenix, and NoSQL. It was created as part of the second assessment for the Senior Backend position at Perqara. The API allows for the creation, reading, updating, and deletion of blog posts, each consisting of a title, author, and content. Posts can have multiple comments, each with an author and content.

## Features

- CRUD Operations: Perform create, read, update, and delete operations on blog posts and comments.
- Rate Limiting: Protects against brute-force and Denial-of-Service (DoS) attacks.
- Eager Loading / Preloading: Optimizes query performance and avoids N+1 query problems, enhancing overall application performance.

## Prerequisites

- Elixir
- Phoenix Framework
- NoSQL Database
- Docker (optional)

## Installation & Running

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Documentation
https://documenter.getpostman.com/view/524864/2s9YR55ESN

## Areas for Improvement

While the application is functional and meets the requirements of the assessment, there are several areas where it can be enhanced:

- Authorization and Authentication: Implementing a system where only the authors of posts and comments have the rights to edit or delete them. This ensures data integrity and security.

- Pagination and Caching: To enhance performance and user experience, incorporating data pagination to limit the amount of transmitted data, and caching to provide quicker access and reduced latency.
