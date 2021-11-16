defmodule ApiWeb.Router do
  use ApiWeb, :router
  use Pow.Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug Api.Auth.AuthFlow, otp_app: :api
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated,
         error_handler: ApiWeb.AuthErrorHandler
  end

  scope "/api/registration", ApiWeb.Controllers do
    pipe_through [:api]

    post "/signup", UserRegistration, :register
    post "/signin", UserLogin, :login
  end

  scope "/api/teams", ApiWeb do
    pipe_through [:api, :api_protected]

    get "/", TeamsController, :index
    get "/:id", TeamsController, :show
    post "/", TeamsController, :create
    delete "/:id", TeamsController, :delete

    put "/adduser/:teamID", TeamsController, :addUserToTeam
    put "/removeuser/:teamID", TeamsController, :removeUserToTeam
  end

  scope "/api/users", ApiWeb do
    pipe_through [:api, :api_protected]

    #GET method: http://localhost:4000/api/users?email=XXX&username=YYY
    get "/", UserController, :showByData
    #GET method: http://localhost:4000/api/users/:userID
    get "/:userID", UserController, :show
    #POST method: http://localhost:4000/api/users
    post "/", UserController, :createUser
    #PUT method: http://localhost:4000/api/users/:userID
    put "/:userID", UserController, :update
    #DELETE method: http://localhost:4000/api/users/:userID
    delete "/:userID", UserController, :delete
  end

  scope "/api/workingtimes", ApiWeb do
    pipe_through [:api, :api_protected]

    #GET(ALL) method: http://localhost:4000/api/workingtimes/:userID?start=XXX&end=YYY
    #GET(ONE) method: http://localhost:4000/api/workingtimes/:id
    get "/:id", WorkingTimesController, :show
    #POST method: http://localhost:4000/api/workingtimes/:userID
    post "/:userID", WorkingTimesController, :create
    #PUT method: http://localhost:4000/api/workingtimes/:id
    put "/:id", WorkingTimesController, :update
    #DELETE method: http://localhost:4000/api/workingtimes/:id
    delete "/:id", WorkingTimesController, :delete

  end

  scope "/api/clocks", ApiWeb do
    pipe_through [:api, :api_protected]

    #GET (all) method: http://localhost:4000/api/clocks/:userID
    get "/", ClocksController, :index
    #GET method: http://localhost:4000/api/clocks/:userID
    get "/:userID", ClocksController, :show
    #POST method: http://localhost:4000/api/clocks/:userID
    post "/:userID", ClocksController, :create

  end

  scope "/api", ApiWeb do
    pipe_through [:api, :api_protected]

  end
end
