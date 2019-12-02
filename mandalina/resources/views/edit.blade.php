@extends('layout.home')
@section('content')

@if(session()->has('message'))
<div class="alert alert-success">
    {{ session()->get('message') }}
</div>
@endif

@php

$description = trim($data[2]['description']);

$genres = array();
foreach($data[2]['genres'] as $item){
array_push($genres, $item->id);
}

$cast = array();
foreach($data[2]['casts'] as $item){
array_push($cast, $item->name);
}
@endphp

<form action="{{url('AdminPanelPinnme/update')}}" onsubmit="return confirm('Do you really want to update it?');" method="post" enctype="multipart/form-data">
    <div class="container-fluid">
        <div class="row">
            @csrf
        <input type="hidden" name="movieid" value="{{$data[2]['id']}}">
        <input type="hidden" name="oldcover" value="{{$data[2]['image']}}">
        <input type="hidden" name="oldlimit" value="{{$data[2]['length']}}">
        <input type="hidden" name="oldvideo" value="{{$data[2]['movieLink']}}">
            <div class="col-6">
                <label for="name">Movie/Series Name: </label>
                <input class="form-control" type="text" name="name" placeholder="Name" value="{{$data[2]['name']}}"
                    required> <br>
                <div>
                        <label for="name">Tag Name: </label>
                <input class="form-control" type="text" name="tag" value="{{$data[2]['tagName']}}" placeholder="Tag Name" required> <br>
                    <label for="Genres">Genres: </label>
                    <select class="js-example-basic-multiple" style="width: 100%" name="genres[]" multiple="multiple"
                        required>
                        @foreach ($data[0] as $item)
                        @if(in_array($item->id, $genres))
                        <option selected value="{{$item->id}}">{{$item->name}}</option>
                        @else
                        <option value="{{$item->id}}">{{$item->name}}</option>
                        @endif
                        @endforeach
                    </select>
                </div> <br>
                <label for="rate">Age Limit</label>
                <input class="form-control" type="text" name="limit" value="{{$data[2]['rate']}}" placeholder="Age Limit" required> <br>
                <div>
                    <label for="cast">Casts: </label>
                    <select class="form-control casting" multiple="multiple" name="cast[]" required>
                        @foreach ($cast as $item)
                        <option selected value="{{$item}}">{{$item}}</option>
                        @endforeach
                    </select>
                </div>
                <br>
                <label for="Genres">Type: </label>
                <div>
                    <select class="js-example-basic-single" style="width: 100%" name="type" required>
                        <option disabled selected value="">Select a Type</option>
                        @foreach ($data[1] as $item)
                            
                        @if($item->id == $data[2]['movieType'])
                        <option selected value="{{$item->id}}">{{$item->name}}</option>
                        @else 
                        <option value="{{$item->id}}">{{$item->name}}</option>
                        @endif

                        @endforeach
                    </select>
                </div><br>
                @if($data[2]['movieType'] == DataManupilation::Movie)
                <div class="movieType">
                @else
                <div class="movieType d-none">
                @endif
                    <label for="length">Movie Duration: </label>
                    <input class="form-control" type="text" name="duration" value="{{$data[2]['length']}}" required
                        placeholder="Only number (as minutes)"><br>
                    <label>Upload Video: </label>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="video" name="video">
                        <label class="custom-file-label" for="video">Choose video</label>
                    </div>
                </div>
            </div>







            <div class="col-6">
                <label for="year">Release Year: </label>
                <input class="form-control" type="text" name="year" placeholder="Year" value="{{$data[2]['year']}}" required> <br>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="my-textarea" class="form-control" name="description" rows="8" required>{{$description}}</textarea>
                </div>
                <label for="image">Cover Image: </label> <br>
                <div>
                    <img id="blah" width="150" src="{{$data[3].$data[2]['image']}}" alt="Cover" />
                </div><br>


                <div class="custom-file">
                    <input type="file" class="custom-file-input" name="cover" id="imgInp">
                    <label class="custom-file-label" for="imgInp">Choose cover</label>
                </div>

            </div>

            <div class="col-12 text-center" style="margin-bottom: 20px"> <br><br>
                <button class="btn btn-primary " type="sunmit">Update</button>
            </div>
        </div>
    </div>


</form>

<script>
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
        $(".movieType").addClass("d-none")
        $(".movieType input").each(function(index){ $(this).prop('required',false) })
      }else{
        $(".movieType").removeClass("d-none")
        $(".movieType input").each(function(index){ $(this).prop('required',true) })
      }
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
</script>
@endsection