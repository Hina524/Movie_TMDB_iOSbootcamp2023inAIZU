import SwiftUI
import Kingfisher

struct FavoriteView: View {
    @State private var movieData: [Popular.Results] = []
    @State private var favoriteMovies: [Popular.Results] = []
    
    let baseURL = "https://image.tmdb.org/t/p/w500/"
    
    var body: some View {
        VStack {
            Text("Favorite")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 5) {
                    ForEach(favoriteMovies, id: \.id) { movie in
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
                                    
                                    HStack(spacing: 3){
                                        Text(movie.originalLanguage)
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                            .frame(width: 25, height: 20)
                                            .background(Color.teal)
                                            .cornerRadius(5)
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
                loadFavorites()
            }
            .refreshable {
                loadFavorites()
            }
        }
    }
    
    func loadFavorites() {
        if let savedMovies = UserDefaults.standard.data(forKey: "FavoriteMovies"),
           let decodedMovies = try? JSONDecoder().decode([Popular.Results].self, from: savedMovies) {
            favoriteMovies = decodedMovies
        }
    }
}

#Preview {
    FavoriteView()
}
