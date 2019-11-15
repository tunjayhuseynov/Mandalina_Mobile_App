@extends('layout.home')
@section('content')

@if(session()->has('message'))
    <div class="alert alert-success">
        {{ session()->get('message') }}
    </div>
@endif

<form action="{{url('AdminPanelPinnme/editEpisode')}}/{{$data->id}}" method="post" enctype="multipart/form-data">
  <div class="container-fluid">
    <div class="row">
      @csrf

      <div class="col-6">
        <label for="name">Episode Name: </label>
        <input class="form-control" type="text" name="name" value="{{$data->name}}" placeholder="Name" required> <br>
        <label for="rate">Season: </label>
      <input class="form-control" type="text" name="season" value="{{$data->season}}" placeholder="Only Number" required> <br>
        <label for="rate">Episode Number: </label>
        <input class="form-control" type="text" name="number" value="{{$data->number}}" placeholder="Only Number" required> <br>
        <div class="movieType">
          <label for="length">Episode Duration: </label>
        <input class="form-control" type="text" value="{{$data->airtime}}" name="duration" required placeholder="Only number (as minutes)"><br>
          <label>Upload Video: </label>
          <div class="custom-file">
              <input type="file" class="custom-file-input" id="video" name="video">
              <input type="hidden" value="{{$data->url}}" name="oldvideo">

              <label class="custom-file-label" id="videoLabel" for="video">Choose video</label>
              <div class="alert alert-success d-none" id="success">
                  File Selected!
                </div>
            </div>
        </div>
      </div>

      <div class="col-6">
        <div class="form-group">
          <label for="description">Description</label>
          <textarea id="my-textarea" class="form-control" name="description" rows="8" required>{{$data->summary}}</textarea>
        </div>
        <label for="image">Cover Image: </label> <br>
        <div>
          <img id="blah" width="150" src="https://via.placeholder.com/150" alt="Cover" />
        </div><br>


        <div class="custom-file">
          <input type="file" class="custom-file-input" name="cover" id="imgInp">
          <label class="custom-file-label" id="coverLabel" for="imgInp">Choose cover</label>
        <input type="hidden" value="{{$data->image}}" name="oldcover">
        </div>

      </div>
     
      <div class="col-12 text-center" style="margin-bottom: 20px"> <br><br>
          <button class="btn btn-primary " type="sunmit">Add</button>
      </div>
    </div>
  </div>


</form>

<script>

$("#video").change(function(){
  if(this.files && this.files[0]){
    $("#videoLabel").html(this.files[0].name)
    $("#success").removeClass("d-none");
  }else{
    $("#success").addClass("d-none");
    $("#videoLabel").html("Choose Video")

  }
})

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    $("#coverLabel").html(input.files[0].name)

    reader.onload = function(e) {
      $('#blah').attr('src', e.target.result);
    }
    
    reader.readAsDataURL(input.files[0]);
  }else{
  $("#coverLabel").html("Choose Cover")
  $('#blah').attr('src', "//via.placeholder.com/150");
  }
}

$("#imgInp").change(function() {
  readURL(this);

});
</script>
@endsection