@extends('layout.home')
@section('content')

@if(session()->has('message'))
    <div class="alert alert-success">
        {{ session()->get('message') }}
    </div>
@endif

<form action="{{url('AdminPanelPinnme/postEpisode')}}" method="post" enctype="multipart/form-data">
  <div class="container-fluid">
    <div class="row">
      @csrf

      <div class="col-6">
        <label for="name">Episode Name: </label>
        <input class="form-control" type="text" name="name" placeholder="Name" required> <br>
        <label for="rate">Season: </label>
        <input class="form-control" type="text" name="season" placeholder="Only Number" required> <br>
        <label for="rate">Episode Number: </label>
        <input class="form-control" type="text" name="number" placeholder="Only Number" required> <br>
        <div class="movieType">
          <label for="length">Episode Duration: </label>
          <input class="form-control" type="text" name="duration" required placeholder="Only number (as minutes)"><br>
          <label>Upload Video: </label>
          <div class="custom-file">
              <input type="file" class="custom-file-input" id="video" name="video" required>
              <label class="custom-file-label" for="video">Choose video</label>
            </div>
        </div>
      </div>

      <div class="col-6">
        <div class="form-group">
          <label for="description">Description</label>
          <textarea id="my-textarea" class="form-control" name="description" rows="8" required></textarea>
        </div>
        <label for="image">Cover Image: </label> <br>
        <div>
          <img id="blah" width="150" src="https://via.placeholder.com/150" alt="Cover" />
        </div><br>


        <div class="custom-file">
          <input type="file" class="custom-file-input" name="cover" id="imgInp" required>
          <label class="custom-file-label" for="imgInp">Choose cover</label>
        </div>

      </div>
     
      <div class="col-12 text-center" style="margin-bottom: 20px"> <br><br>
          <button class="btn btn-primary " type="sunmit">Add</button>
      </div>
    </div>
  </div>


</form>

<script>


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
</script>
@endsection