@extends('layout.home')
@section('content')

@if(session()->has('message'))
<div class="alert alert-success">
    {{ session()->get('message') }}
</div>
@endif

<form action="{{url('AdminPanelPinnme/postSuggestion')}}" method="POST">
    @csrf
    <label>Suggested Movie: </label> <br>
    <select name="selection">
        @foreach ($movies[1] as $movie)
        <option {{ ($movie->id == $movies[0]->movieID)? "selected" : '' }} value="{{$movie->id}}">{{$movie->name}}
        </option>
        @endforeach

    </select>

    <br> <br>
    <button type="submit" class="btn btn-primary" style="background-color: #ff861f; border: none ">Submit</button>

</form>
@endsection