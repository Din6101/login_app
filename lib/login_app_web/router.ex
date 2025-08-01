defmodule LoginAppWeb.Router do
  use LoginAppWeb, :router

  import LoginAppWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LoginAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LoginAppWeb do
    pipe_through :browser



    get "/", PageController, :home
  end



  # Other scopes may use custom stacks.
  # scope "/api", LoginAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:login_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LoginAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", LoginAppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{LoginAppWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", LoginAppWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
    layout: {LoginAppWeb.Layouts, :app},
      on_mount: [{LoginAppWeb.UserAuth, :ensure_authenticated},
                  {LoginAppWeb.UserAuth, :mount_current_user}
                  ] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

      # Admin Dashboard Route
      live "/student/dashboard", StudentDashboardLive
      live "/admin/dashboard", AdminDashboardLive
      live "/notifications", NotificationsLive
      live "/profile", ProfileLive

      live "/students", StudentLive.Index, :index
      live "/students/new", StudentLive.Index, :new
      live "/students/:id/edit", StudentLive.Index, :edit

      live "/students/:id", StudentLive.Show, :show
      live "/students/:id/show/edit", StudentLive.Show, :edit

      live "/teachers", TeacherLive.Index, :index
      live "/teachers/new", TeacherLive.Index, :new
      live "/teachers/:id/edit", TeacherLive.Index, :edit

      live "/teachers/:id", TeacherLive.Show, :show
      live "/teachers/:id/show/edit", TeacherLive.Show, :edit

      live "/courses", CoursesLive.Index, :index
      live "/courses/new", CoursesLive.Index, :new
      live "/courses/:id/edit", CoursesLive.Index, :edit

      live "/courses/:id", CoursesLive.Show, :show
      live "/courses/:id/show/edit", CoursesLive.Show, :edit

      live "/enrollments", EnrollmentsLive.Index, :index
      live "/enrollments/new", EnrollmentsLive.Index, :new
      live "/enrollments/:id/edit", EnrollmentsLive.Index, :edit

      live "/enrollments/:id", EnrollmentsLive.Show, :show
      live "/enrollments/:id/show/edit", EnrollmentsLive.Show, :edit

      live "/results", ResultsLive.Index, :index
      live "/results/new", ResultsLive.Index, :new
      live "/results/:id/edit", ResultsLive.Index, :edit

      live "/results/:id", ResultsLive.Show, :show
      live "/results/:id/show/edit", ResultsLive.Show, :edit

      live "/certifications", CertificationsLive.Index, :index
      live "/certifications/new", CertificationsLive.Index, :new
      live "/certifications/:id/edit", CertificationsLive.Index, :edit

      live "/certifications/:id", CertificationsLive.Show, :show
      live "/certifications/:id/show/edit", CertificationsLive.Show, :edit

      live "/reports", ReportsLive.Index, :index
      live "/reports/new", ReportsLive.Index, :new
      live "/reports/:id/edit", ReportsLive.Index, :edit

      live "/reports/:id", ReportsLive.Show, :show
      live "/reports/:id/show/edit", ReportsLive.Show, :edit
    end
  end

  scope "/", LoginAppWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{LoginAppWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
