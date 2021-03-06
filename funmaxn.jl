# suguest to use julia function partialsortperm instead of this.
# we have an easy use in dict.xlsx and some function both have or similar.
function maxk(M::AbstractArray, k::Integer)
    nlen=prod(size(M))
    if k> nlen || k< 1
        error("error length")
    end
    T=eltype(M)
    A=zeros(T,k);
    md=mx=zero(T);

    for i=1:nlen
      j = k;
      kth=k+1;
      while A[j]<M[i]
            kth=j
            j=j-1;
            if j==1
                break
            end
      end
        if A[j]<M[i]
           kth=j;
        end
        if kth< k+1
            A=[A[1:kth-1];M[i];A[kth:k-1]];
        end
    end
    return A
end
# suguest to use other function if k is bigger
function maxk(M::AbstractArray, k::Integer, dim::Integer) 
    if ndims(M)>2
        error("only spport ndims= 1 , 2")
    elseif dim>2 || dim<1
        error("give a invalid ndims")
    end
    m,n=size(M)
    v0=Array{eltype(A)}(undef,0)
    if dim==1
        for i=1:n
            temp=M[:,i];
            vtemp=maxn(temp,k);
            v0=[v0;vtemp];
        end
        B=reshape(v0,k,n)
    elseif dim==2
        for i=1:m
            temp=M[i,:];
            vtemp=maxk(temp,k);
            v0=[v0;vtemp];
        end
        B=reshape(v0,k,m);
        B=B';
    end
    return B
end

function maxk2(M::AbstractArray, k::Integer)
    nlen=prod(size(M))
    if k> nlen || k< 1
        error("error length")
    elseif k>0 && k< 11
        println("suggest use maxn instead for more speed")
    end
    A=M[1:k];
    A=sort(A,rev=true);
    for i=k+1:nlen
        for j= k:-1:1
            if M[i]<A[j]
            break
        end
        if j< k-1
           A=[A[1:j];M[i];A[j+1:k-1]]; 
        end
    end
    A=sort(A,rev=true);
    return A
end
"""
A=rand(4,5)

maxn(A,2,1)

maxn(A,2,2)

A=rand(Int16,10000);
    
maxn2(A,100);
    
"""
