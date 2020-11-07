@extends('layout.home')
@section('content')

@if(session()->has('message'))
    <div class="alert alert-success">
        {{ session()->get('message') }}
    </div>
@endif

<form action="{{url('AdminPanelPinnme/Movieadding/')}}" method="post" enctype="multipart/form-data">
  <div class="container-fluid">
    <div class="row">
      @csrf

      <div class="col-6">
        <label for="name">Movie/Series Name: </label>
        <input class="form-control" type="text" name="name" placeholder="Name" required> <br>
        <div>
            <label for="name">Tag Name: </label>
            <input class="form-control" type="text" onchange="getInput(this)" name="tag" placeholder="Tag Name" required> <br>
          <label for="Genres">Genres: </label>
          <select class="js-example-basic-multiple" style="width: 100%" name="genres[]" multiple="multiple" required>
            @foreach ($data[0] as $item)
            <option value="{{$item->id}}">{{$item->name}}</option>
            @endforeach
          </select>
        </div> <br>
        <label for="rate">Age Limit</label>
        <input class="form-control" type="text" name="limit" placeholder="Age Limit" required> <br>
        <label for="rate">IMDB</label>
        <input class="form-control" type="text" name="imdb" placeholder="IMDB" required> <br>
        <div>
          <label for="cast">Casts: </label>
          <select class="form-control casting" multiple="multiple" name="cast[]" required>
          </select>
        </div>
        <br>
        <div>
          <label>Trailer Link: </label>
          <input class="form-control" type="text" name="trailer" placeholder="Trailer Link" required> <br>
          </div>
        <br>
        <label for="Genres">Type: </label>
        <div>
          <select class="js-example-basic-single" style="width: 100%" name="type" required>
            <option disabled selected value="">Select a Type</option>
            @foreach ($data[1] as $item)
 
            <option value="{{$item->id}}">{{$item->name}}</option>

            @endforeach
          </select>
        </div><br>
        <div class="movieType d-none">
          <label for="length">Movie Duration: </label>
          <input class="form-control" type="text" name="duration" placeholder="Only number (as minutes)"><br>
          <label>Turkish Link: </label>
          <input class="form-control" type="text" name="movie" placeholder="Only ID from Link"> <br>
          <label>English Link: </label>
          <input class="form-control" type="text" name="enmovie" placeholder="Only ID from Link"> <br>
          <label>Turkish Subtitle Link: </label>
          <input class="form-control" type="text" name="subtitle" placeholder="Full Link"> <br>
          <label>English Subtitle Link: </label>
          <input class="form-control" type="text" name="enSubtitle" placeholder="Full Link"> <br>
        </div>
        <div class="tvType d-none">
          <input class="form-check-input" type="checkbox" name="isTurkish">
          <label class="form-check-label" for="isTurkish">Turkish? </label><br>
          <input class="form-check-input" type="checkbox" name="isEnglish">
          <label class="form-check-label" for="isEnglish">English? </label><br>
        </div>
      </div>

      <div class="col-6">
        <label for="year">Release Year: </label>
        <input class="form-control" type="text" name="year" placeholder="Year" required> <br>
        <div class="form-group">
          <label for="description">Description</label>
          <textarea id="my-textarea" class="form-control" name="description" rows="8" required></textarea>
        </div>
        <label for="image">Cover & Poster Image: </label> <br>
        <div>
          <img id="blah" width="150" src="https://via.placeholder.com/150" alt="Cover" />
          <img id="blahPoster" width="350" src="https://via.placeholder.com/350x200" alt="Poster" />
        </div><br>


        <!-- <div class="custom-file">
          <input type="file" class="custom-file-input" name="cover" id="imgInp" required>
          <label class="custom-file-label" for="imgInp">Choose cover</label>
        </div> -->
        <input class="form-control" type="text" name="cover" id="imageUrl" placeholder="Cover Link" required> <br>
        <input class="form-control" type="text" name="poster" id="posterUrl" placeholder="Poster Link" required> <br>
        <button type="button"  class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
            Open Cover Selector
        </button>
      </div>
     
      <div class="col-12 text-center" style="margin-bottom: 20px"> <br><br>
          <button class="btn btn-primary " type="submit" formmethod="post" formaction="{{url('AdminPanelPinnme/Movieadding/')}}">Add</button>
      </div>
    </div>
  </div>

</form>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="max-width: 90%">
    <div class="modal-content">
      <div class="modal-header" style="display: inline">
        <input type="text" placeholder="Enter Movie Name" id="searchInput">
        <button class="btn primary-btn" id="searchBtn">Search Cover</button>
        <button class="btn primary-btn" id="searchPosterBtn">Search Poster</button>
      </div>
      <div class="modal-body" id="modalbody">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
  var type = 1;
  $(document).ready(function() {

    $('.js-example-basic-multiple').select2({
        placeholder: 'Select Genres',
        width: 'resolve',

    });
    $('.js-example-basic-single').select2({
        width: 'resolve',
        minimumResultsForSearch: Infinity

    });

    $('.casting').select2({
        width: 'resolve',
        tags: true,
        minimumResultsForSearch: Infinity

    });

    $(".js-example-basic-single").on('change', function(){
      if(this.value == 2){
        type = 2
        $(".movieType").addClass("d-none")
        //$(".movieType input").each(function(index){ $(this).prop('required',false) })

        $(".tvType").removeClass("d-none")
        
      }else{
        type = 1
        $(".movieType").removeClass("d-none")
        //$(".movieType input").each(function(index){ $(this).prop('required',true) })

        $(".tvType").addClass("d-none")
      }
    })

    $("#searchBtn").click(function(){
      movieFun(type, true)
    })
    $("#searchPosterBtn").click(function(){
      movieFun(type, false)
    })

});

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    
    reader.onload = function(e) {
      $('#blah').attr('src', e.target.result);
    }
    
    reader.readAsDataURL(input.files[0]);
  }
}

$("#imgInp").change(function() {
  readURL(this);
});


async function movieFun(type, isCover){
  var urlApi;
        console.log("type is " +type)
        if(type == 1){
            urlApi = 'https://api.themoviedb.org/3/search/movie?api_key=285a107f0c92cfda467db221ccc502f7&query='
        }else{
            urlApi = 'https://api.themoviedb.org/3/search/tv?api_key=285a107f0c92cfda467db221ccc502f7&query='
        }
  var query = document.querySelector("#searchInput").value
  
  document.querySelector("#modalbody").innerHTML = ""

  let firstFetch = await fetch(urlApi+query);
  let firstJson = await firstFetch.json()

  let movies = firstJson.results;

    movies.forEach(function(item, index){
      if((isCover && item.poster_path != null) || (!isCover && item.backdrop_path != null) ){
      var image = new Image()
      image.src = 'https://image.tmdb.org/t/p/' + (isCover?'w780/'+item.poster_path:'original/'+item.backdrop_path);
      image.width = isCover?"150":"350"
      image.style.margin = "15px 15px 0 0"
      image.style.cursor = "pointer"
      image.addEventListener("click", function(){
        if(isCover){
          document.querySelector("#imageUrl").value = image.src
          document.querySelector("#blah").src = image.src
        }else{
          document.querySelector("#posterUrl").value = image.src
          document.querySelector("#blahPoster").src = image.src
        }
        $('#exampleModal').modal('hide')
      })
      $("#modalbody")[0].append(image)
    }
  })

}

async function getInput(val) {
  let casts = new Array()
  val = val.value
  let urlApi;
 
        console.log("type is " +type)
        if(type == 1){
            urlApi = 'https://api.themoviedb.org/3/search/movie?api_key=285a107f0c92cfda467db221ccc502f7&query='
        }else{
            urlApi = 'https://api.themoviedb.org/3/search/tv?api_key=285a107f0c92cfda467db221ccc502f7&query='
        }
  
        const firstFetch = await fetch(urlApi+val);
        let movie = await firstFetch.json()

        movie.results.forEach(async e=>{
          const seconFetch = await fetch(type==1?
          `https://api.themoviedb.org/3/movie/${e.id}/credits?api_key=285a107f0c92cfda467db221ccc502f7`:
          `https://api.themoviedb.org/3/tv/${e.id}/credits?api_key=285a107f0c92cfda467db221ccc502f7`);

          const secondJson = await seconFetch.json();

          secondJson.cast.forEach(e=>{
            if(!casts.includes(e.name)){
            casts.push(e.name)
            document.querySelector(".casting").innerHTML += `<option value="${e.name}">${e.name}</option>`
            }
          })
        })  
}

</script>
@endsection