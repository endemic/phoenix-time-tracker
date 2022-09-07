defmodule TimeTrackerWeb.ProjectController do
  use TimeTrackerWeb, :controller

  alias TimeTracker.Accounts
  alias TimeTracker.Accounts.Project

  def index(conn, _params) do
    projects = Accounts.list_projects()
    render(conn, "index.html", projects: projects)
  end

  def new(conn, _params) do
    client_options = Accounts.client_options()
    changeset = Accounts.change_project(%Project{})
    render(conn, "new.html", changeset: changeset, client_options: client_options)
  end

  def create(conn, %{"project" => project_params}) do
    case Accounts.create_project(project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        client_options = Accounts.client_options()
        render(conn, "new.html", changeset: changeset, client_options: client_options)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Accounts.get_project!(id)
    render(conn, "show.html", project: project)
  end

  def edit(conn, %{"id" => id}) do
    project = Accounts.get_project!(id)
    changeset = Accounts.change_project(project)
    render(conn, "edit.html", project: project, changeset: changeset)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Accounts.get_project!(id)

    case Accounts.update_project(project, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project: project, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Accounts.get_project!(id)
    {:ok, _project} = Accounts.delete_project(project)

    conn
    |> put_flash(:info, "Project deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :index))
  end
end
