defmodule MediaServer.WatchesTest do
  use MediaServer.DataCase

  alias MediaServer.AccountsFixtures
  alias MediaServer.Watches

  describe "movie_watches" do
    alias MediaServer.Watches.Movie

    import MediaServer.WatchesFixtures

    @invalid_attrs %{
      movie_id: nil,
      title: nil,
      image_url: nil,
      current_time: nil,
      duration: nil,
      user_id: nil
    }

    test "list_movie_watches/0 returns all movie_watches" do
      user = AccountsFixtures.user_fixture()
      movie = movie_fixture(%{user_id: user.id})
      assert Watches.list_movie_watches() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      user = AccountsFixtures.user_fixture()
      movie = movie_fixture(%{user_id: user.id})
      assert Watches.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      valid_attrs = %{
        movie_id: 42,
        title: "some title",
        image_url: "some image url",
        current_time: 42,
        duration: 84,
        user_id: AccountsFixtures.user_fixture().id
      }

      assert {:ok, %Movie{} = movie} = Watches.create_movie(valid_attrs)
      assert movie.movie_id == 42
      assert movie.title == "some title"
      assert movie.image_url == "some image url"
      assert movie.current_time == 42
      assert movie.duration == 84
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Watches.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      user = AccountsFixtures.user_fixture()
      movie = movie_fixture(%{user_id: user.id})
      update_attrs = %{
        movie_id: 43,
        title: "update title",
        image_url: "update image url",
        current_time: 62,
        duration: 86,
        user_id: user.id
      }

      assert {:ok, %Movie{} = movie} = Watches.update_movie(movie, update_attrs)
      assert movie.movie_id == 43
      assert movie.title == "update title"
      assert movie.image_url == "update image url"
      assert movie.current_time == 62
      assert movie.duration == 86
    end

    test "update_movie/2 with invalid data returns error changeset" do
      user = AccountsFixtures.user_fixture()
      movie = movie_fixture(%{user_id: user.id})
      assert {:error, %Ecto.Changeset{}} = Watches.update_movie(movie, @invalid_attrs)
      assert movie == Watches.get_movie!(movie.id)
    end

    test "update_or_create_movie/2 updates movie" do
      user = AccountsFixtures.user_fixture()
      movie_fixture(%{user_id: user.id})
      update_attrs = %{
        movie_id: 42,
        current_time: 89,
        duration: 100,
        user_id: user.id
      }

      {:ok, %Movie{} = movie} = Watches.update_or_create_movie(update_attrs)
      assert movie.movie_id == 42
      assert movie.current_time == 89
      assert movie.duration == 100
      assert movie.user_id == user.id
    end

    test "update_or_create_movie/2 deletes movie" do
      user = AccountsFixtures.user_fixture()
      movie_fixture(%{user_id: user.id})
      update_attrs = %{
        movie_id: 42,
        current_time: 90,
        duration: 100,
        user_id: user.id
      }

      refute Watches.update_or_create_movie(update_attrs)
    end

    test "update_or_create_movie/2 creates movie" do
      user = AccountsFixtures.user_fixture()
      movie_fixture(%{user_id: user.id})
      update_attrs = %{
        movie_id: 43,
        title: "update title",
        image_url: "update image url",
        current_time: 62,
        duration: 86,
        user_id: user.id
      }
      assert {:ok, %Movie{} = movie} = Watches.update_or_create_movie(update_attrs)
      assert movie.movie_id == 43
      assert movie.title == "update title"
      assert movie.image_url == "update image url"
      assert movie.current_time == 62
      assert movie.duration == 86
      assert movie.user_id == user.id
    end

    test "delete_movie/1 deletes the movie" do
      user = AccountsFixtures.user_fixture()
      movie = movie_fixture(%{user_id: user.id})
      assert {:ok, %Movie{}} = Watches.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> Watches.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      user = AccountsFixtures.user_fixture()
      movie = movie_fixture(%{user_id: user.id})
      assert %Ecto.Changeset{} = Watches.change_movie(movie)
    end
  end

  describe "episode_watches" do
    alias MediaServer.Watches.Episode

    import MediaServer.WatchesFixtures

    @invalid_attrs %{
      current_time: nil,
      duration: nil,
      episode_id: nil,
      image_url: nil,
      serie_id: nil,
      title: nil,
      user_id: nil
    }

    test "list_episode_watches/0 returns all episode_watches" do
      user = AccountsFixtures.user_fixture()
      episode = episode_fixture(%{user_id: user.id})
      assert Watches.list_episode_watches() == [episode]
    end

    test "get_episode!/1 returns the episode with given id" do
      user = AccountsFixtures.user_fixture()
      episode = episode_fixture(%{user_id: user.id})
      assert Watches.get_episode!(episode.id) == episode
    end

    test "create_episode/1 with valid data creates a episode" do
      user = AccountsFixtures.user_fixture()
      valid_attrs = %{
        current_time: 42,
        duration: 42,
        episode_id: 42,
        image_url: "some image_url",
        serie_id: 42,
        title: "some title",
        user_id: user.id
      }

      assert {:ok, %Episode{} = episode} = Watches.create_episode(valid_attrs)
      assert episode.current_time == 42
      assert episode.duration == 42
      assert episode.episode_id == 42
      assert episode.image_url == "some image_url"
      assert episode.serie_id == 42
      assert episode.title == "some title"
      assert episode.user_id == user.id
    end

    test "create_episode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Watches.create_episode(@invalid_attrs)
    end

    test "update_episode/2 with valid data updates the episode" do
      user = AccountsFixtures.user_fixture()
      episode = episode_fixture(%{user_id: user.id})
      update_attrs = %{
        current_time: 43,
        duration: 43,
        episode_id: 43,
        image_url: "some updated image_url",
        serie_id: 43,
        title: "some updated title",
        user_id: user.id
      }

      assert {:ok, %Episode{} = episode} = Watches.update_episode(episode, update_attrs)
      assert episode.current_time == 43
      assert episode.duration == 43
      assert episode.episode_id == 43
      assert episode.image_url == "some updated image_url"
      assert episode.serie_id == 43
      assert episode.title == "some updated title"
      assert episode.user_id == user.id
    end

    test "update_episode/2 with invalid data returns error changeset" do
      user = AccountsFixtures.user_fixture()
      episode = episode_fixture(%{user_id: user.id})
      assert {:error, %Ecto.Changeset{}} = Watches.update_episode(episode, @invalid_attrs)
      assert episode == Watches.get_episode!(episode.id)
    end

    test "update_or_create_episode/2 updates episode" do
      user = AccountsFixtures.user_fixture()
      episode_fixture(%{user_id: user.id})
      update_attrs = %{
        episode_id: 42,
        serie_id: 42,
        current_time: 89,
        duration: 100,
        user_id: user.id
      }

      {:ok, %Episode{} = episode} = Watches.update_or_create_episode(update_attrs)
      assert episode.duration == 100
      assert episode.current_time == 89
      assert episode.episode_id == 42
      assert episode.serie_id == 42
      assert episode.user_id == user.id
    end

    test "update_or_create_movie/2 deletes movie" do
      user = AccountsFixtures.user_fixture()
      episode_fixture(%{user_id: user.id})
      update_attrs = %{
        episode_id: 42,
        serie_id: 42,
        current_time: 90,
        duration: 100,
        user_id: user.id
      }

      refute Watches.update_or_create_episode(update_attrs)
    end

    test "update_or_create_episode/2 creates episode" do
      user = AccountsFixtures.user_fixture()
      episode_fixture(%{user_id: user.id})
      update_attrs = %{
        episode_id: 43,
        serie_id: 43,
        title: "update title",
        image_url: "update image url",
        current_time: 62,
        duration: 86,
        user_id: user.id
      }
      assert {:ok, %Episode{} = episode} = Watches.update_or_create_episode(update_attrs)
      assert episode.episode_id == 43
      assert episode.title == "update title"
      assert episode.image_url == "update image url"
      assert episode.current_time == 62
      assert episode.duration == 86
      assert episode.user_id == user.id
    end

    test "delete_episode/1 deletes the episode" do
      user = AccountsFixtures.user_fixture()
      episode = episode_fixture(%{user_id: user.id})
      assert {:ok, %Episode{}} = Watches.delete_episode(episode)
      assert_raise Ecto.NoResultsError, fn -> Watches.get_episode!(episode.id) end
    end

    test "change_episode/1 returns a episode changeset" do
      user = AccountsFixtures.user_fixture()
      episode = episode_fixture(%{user_id: user.id})
      assert %Ecto.Changeset{} = Watches.change_episode(episode)
    end
  end
end
