TeamCollabs

TeamCollabs is a web application built to help software development teams manage their tasks.
Getting Started
Prerequisites

    Ruby version: 3.0.2
    Rails version: 7.0.5

Installation

    Clone the repository: git clone https://github.com/TeamCollabs/TeamCollabs.git
    Install dependencies: bundle install
    Create the database: rails db:create
    Run database migrations: rails db:migrate
    Seed the database with sample data: rails db:seed

Usage

To run the application, start the Rails server: rails s

The landing page will prompt you to sign in if you already have an account. Otherwise, click "get started" to sign up. You can also log in using any of the users in the seeds.
Credentials

    Teamleader login:
        Email: leader@teamcollab.com
        Password: 123123
    Teammember login:
        Email: member1@teamcollab.com
        Password: 123123

You can create two types of users:

    Teamleader: A team leader can create task pools (task pool is a tasks container), assign team members to tasks, update tasks, and has access to all resources.
    Teammember: A team member can only access limited resources like creating tasks or assigning team members to tasks or accessing the dashboard. But a team member can change progress status and attach files on tasks that are assigned to him.

To access and view tasks using either a team leader or team member account, click on the "Task Pools" tab at the top side of the application header. You'll be able to see task pools you belong to. If you can't find any task pools, that means that you're not assigned to any tasks (if you're a regular user) or you haven't created any task pools yet (if you're a team leader). Adding a task to a task pool is handled by Ajax.

File attachments are enabled for a team member if assigned to a task and, of course, his own team leader. Attached files are stored in Amazon S3.

Dashboards are useful for team leaders to monitor the total number of tasks, overdue tasks, and finished tasks in all task pools they manage.

To run the test suite, use the following command: bundle exec rspec

If there're any inquiries, please send an email to : MahmoudCIT@gmail.com 
