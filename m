Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Aug 2016 08:45:12 +0200
Message-ID: <1663649.BbZ0OMDasJ@bentobox>
In-Reply-To: <1472157596-19774-2-git-send-email-jhaws@sdl.usu.edu>
References: <1472157596-19774-1-git-send-email-jhaws@sdl.usu.edu>
 <1472157596-19774-2-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3149617.tUlYru9Bkc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Adding time_subtract utility
	function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart3149617.tUlYru9Bkc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 25. August 2016 14:39:56 CEST Jonathan Haws wrote:
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
> 
> Added time_subtract() utility function to use for simply subtracting
> one timespec from another.
> ---

Please add a small changelog when you send a new revision (after the first 
"---"). Please also add the v2/v3/v4/... version to your [PATCH...] prefix for 
patches replacing an older version. These are generated automatically by git-
format-patch when you add the parameter "-v 2" or "-v 3" or ....

A good example is https://patchwork.open-mesh.org/patch/16663/

Please use the format described in
 https://www.kernel.org/doc/Documentation/SubmittingPatches

    The canonical patch subject line is:
    
    Subject: [PATCH 001/123] subsystem: summary phrase

    The canonical patch message body contains the following:
    
      - A "from" line specifying the patch author (only needed if the person
        sending the patch is not the author).
    
      - An empty line.
    
      - The body of the explanation, line wrapped at 75 columns, which will
        be copied to the permanent changelog to describe this patch.
    
      - The "Signed-off-by:" lines, described above, which will
        also go in the changelog.
    
      - A marker line containing simply "---".
    
      - Any additional comments not suitable for the changelog.
    
      - The actual patch (diff output).

You don't seem to follow these rules yet. Instead you seem switch the Signed-
off-by: line with the body of the explanation. So a git-am with -s (as the 
maintainers do here) would then produce this mess:

    alfred: Adding time_subtract utility function
    
    Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
    
    Added time_subtract() utility function to use for simply subtracting
    one timespec from another.
    Signed-off-by: Sven Eckelmann <sven@narfation.org>


[...]
> index c5df945..884a1a7 100644
> --- a/server.c
> +++ b/server.c
> @@ -372,7 +372,10 @@ int alfred_server(struct globals *globals)
> 
>  	while (1) {
>  		clock_gettime(CLOCK_MONOTONIC, &now);
> -		time_diff(&now, &globals->sync_period, &now);
> +
> +		/* subtract the synchronization period from the current time */
> +		time_subtract(&now, &globals->sync_period, &now);
> +

I'm guessing Simon meant to have the comment in the first patch. I don't get 
why you now introduce a time_subtract which is just a copy of time_diff 
(without the return value).

> +void time_subtract(struct timespec *tv1, struct timespec *tv2,
> +	      struct timespec *tvout) {
> +	tvout->tv_sec = tv1->tv_sec - tv2->tv_sec;
> +	if (tv1->tv_nsec < tv2->tv_nsec) {
> +		tvout->tv_nsec = 1000000000 + tv1->tv_nsec - tv2->tv_nsec;
> +		tvout->tv_sec -= 1;
> +	} else {
> +		tvout->tv_nsec = tv1->tv_nsec - tv2->tv_nsec;
> +	}

Have you checked the glibc documentation about this topic (search for 
timeval_subtract)?

https://www.gnu.org/software/libc/manual/html_node/Elapsed-Time.html

This might be relevant when you want to create an function which does handle 
more things than time_diff currently does. Otherwise I don't see a reason why 
we just have the same code twice in util.c

> +
> +	return;
> +}
> +

Why a return here?


Btw. I am seeing whitespace warnings when applying the patches. Maybe you can 
check them:

Applying patch #16667 using 'git am'
Description: [1/2] alfred: Externalized synchronization interval
Applying: alfred: Externalized synchronization interval
.git/rebase-apply/patch:89: trailing whitespace.
ALFRED_INTERVAL setting of 10 seconds will be used. Fractional seconds are 
warning: 1 line adds whitespace errors.
Applying patch #16668 using 'git am'
Description: [2/2] alfred: Adding time_subtract utility function
Applying: alfred: Adding time_subtract utility function

Kind regards,
	Sven
--nextPart3149617.tUlYru9Bkc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXv+V4AAoJEF2HCgfBJntG2C4P/3Xwe9aBRJH78ujzIlnlon0h
S4TrULnHWnenNLKJpKCP0rC04U/hhkF3y7Q9MveKaJYncQVxw5TyUkxKsH+fYyz3
9gTc+TU+kolpiHq4HUc0gvzkL+mZElkDErnFeZTmprmrmkUUqn0C7ztQ9eT8Phgy
7VoRV4KKSsnjkuiEV3R0yLy9f5TEHMFs4x/Z7DjyBzTTTNWHNXcrzvb4/cEzkiuS
yy91ys+yMy4/u+/mBUQcwcPH5POJx6LhFPxWvvK5Br2YlY9Hi8UFEG4NiDk5n9px
yb4lFNdM/ylPmvlo0IJesYRWlK6dUms49/yDRCIjtBQ5fyKQzlupohSPc2rKVPXj
whMyTPOeggulL2ajocgTEZXgkN73AeyPz2OkY0CB2nY8B/fb5ZprXmNX7r5bzaGT
ShJPAFmxr6Q3ZjmXL2vUkMLvo+l4uZnOFCtzmuXlkCyvJaxpB2VAF11fhptt6Nkw
et7bVh0cOunkKv+q36oJN0F06fgpVFh5WmW4QNYbrtfahf7MJVwIvI9Cr4ZKfFJN
2m1Lb/9lcNUBaPIWGzCVN0dY0/E4vqt6gOvx5DgCfD9Jknp1hTd8R1+qdDRboicI
T+CXiMAnozhMCHPE/pq6qr1MtyZaFEf3Pq+EpePUvEf6Fe6VaTs0KudiA1Bqltc7
SXlBI8eMfvel/I7JZPqv
=78GY
-----END PGP SIGNATURE-----

--nextPart3149617.tUlYru9Bkc--

