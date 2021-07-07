class Controller < Sinatra::Base

  # sets the root as the parent-directory (web-app-homework folder) of the current File
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new{File.join(root, "views")}

  set :public_folder, File.dirname(__FILE__) + "media"

  configure :development do
    register Sinatra::Reloader
  end

  $posts = [{
    id: 0,
    title: "Man punches Kangaroo",
    post_body: "Man gets into it with kangaroo.",
    video_thumbnail: "https://us-east-1.tchyn.io/snopes-production/uploads/2016/12/man-punches-kangaroo.jpg?resize=865%2C452",
    video_description: ""
    },
    {
      id: 1,
      title: "The Equalizer 2",
      post_body: "Trailer for The Equalizer 2",
      video_thumbnail: "https://www.sliceofscifi.com/wp-content/uploads/2018/07/EQ2-feat.jpg",
      video_description: ""
      },
      {
        id: 2,
        title: "Monkey riding bike around car park",
        post_body: "Monkey steals bike and takes it on a joy ride.",
        video_thumbnail: "https://i.dailymail.co.uk/i/newpix/2018/07/27/20/4EA1579100000578-6000089-image-m-4_1532719096213.jpg",
        video_description: ""
        }]

  get "/" do
    @title = "Video Posts"
    @posts = $posts
    erb :"pages/index"
  end

  get "/new" do
    @title = "Upload a new video"
    @post = {
      id: "",
      title: "",
      post_body: ""
    }
    erb :"pages/new"
  end

  get "/:id" do
    id = params[:id].to_i
    @title = "Video #{id}"
    @post = $posts[id]
    erb :"pages/show"
  end

  post "/" do
    new_post = {
      id: $posts.length,
      title: params[:title],
      post_body: params[:post_body]
    }
    $posts.push(new_post)
    redirect "/"
  end

  put "/:id" do
    id = params[:id].to_i

    post = $posts[id]

    post[:title] = params[:title]
    post[:post_body] = params[:post_body]

    $posts[id] = post

    redirect "/"
  end

  delete "/:id" do
    id = params[:id].to_i
    $posts.delete_at(id)
    redirect "/"
  end

  get "/:id/edit" do
    @title = "Edit your video post"
    id = params[:id].to_i
    @post = $posts[id]

    erb :"pages/edit"
  end

end
