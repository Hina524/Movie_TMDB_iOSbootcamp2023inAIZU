import SwiftUI
import Kingfisher
struct PopularView: View {
    @State private var apiResponse: String = ""
    @State private var movieData: [Popular.Results] = []
    @State private var favoriteMovies: [Popular.Results] = []
    
    let baseURL = "https://image.tmdb.org/t/p/w500/"
    
    var body: some View {
        VStack {
            Text("Popular")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 5) {
                    ForEach(movieData) { movie in
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(alignment: .top) {
                                KFImage(URL(string: baseURL + movie.posterPath)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                    
                                    HStack(spacing: 3) {
                                        Text(movie.originalLanguage)
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                            .frame(width: 25, height: 20)
                                            .background(Color.teal)
                                            .cornerRadius(5)
                                        Button(action: {
                                            toggleFavorite(movie: movie)
                                        }) {
                                            Image(systemName: favoriteMovies.contains(where: { $0.id == movie.id }) ? "heart.fill" : "heart")
                                                .foregroundColor(favoriteMovies.contains(where: { $0.id == movie.id }) ? .pink : .gray)
                                        }
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Text(String(round(movie.voteAverage * 10) / 10))
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Text(movie.releaseDate)
                                        .foregroundColor(.secondary)
                                        .font(.caption2)
                                    Text(movie.overview)
                                        .font(.footnote)
                                        .lineLimit(10)
                                        .truncationMode(.tail)
                                }
                            }
                        }
                        .padding()
                        Divider()
                            .padding()
                    }
                }
            }
            .onAppear {
                popularMovie()
            }
            .refreshable {
                popularMovie()
            }
        }
    }
    
    func popularMovie() {
        GetData.getData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let responseString = String(data: data, encoding: .utf8) {
                        self.apiResponse = responseString
                        do {
                            let popularmovie = try JSONDecoder().decode(Popular.self, from: data)
                            movieData = popularmovie.results
                        } catch {
                            self.apiResponse = "データのデコードに失敗しました: \(error)"
                            print("デコードエラー: \(error)")
                        }
                    } else {
                        self.apiResponse = "データを文字列に変換できませんでした。"
                        print("データ変換エラー。")
                    }
                case .failure(let error):
                    self.apiResponse = "エラー: \(error.localizedDescription)"
                    print("ネットワークエラー: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func toggleFavorite(movie: Popular.Results) {
        if let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
            // 既にお気に入りに追加されている場合、削除する
            favoriteMovies.remove(at: index)
        } else {
            // お気に入りに追加されていない場合、追加する
            favoriteMovies.append(movie)
        }
        
        // お気に入りの映画データを UserDefaults に保存する
        if let encoded = try? JSONEncoder().encode(favoriteMovies) {
            UserDefaults.standard.set(encoded, forKey: "FavoriteMovies")
        }
    }
    
    func loadFavorites() {
        // UserDefaults からお気に入りの映画データを読み込む
        if let savedMovies = UserDefaults.standard.data(forKey: "FavoriteMovies"),
           let decodedMovies = try? JSONDecoder().decode([Popular.Results].self, from: savedMovies) {
            favoriteMovies = decodedMovies
        }
    }
}

#Preview {
    PopularView()
}
