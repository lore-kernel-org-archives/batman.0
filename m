Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 06 Sep 2016 09:39:20 +0200
Message-ID: <3771083.DlN5BzGBr0@prime>
In-Reply-To: <1472223771.12832.15.camel@sdl.usu.edu>
References: <1472157596-19774-1-git-send-email-jhaws@sdl.usu.edu>
 <1663649.BbZ0OMDasJ@bentobox> <1472223771.12832.15.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13643698.1f5CdSmA7F";
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
To: b.a.t.m.a.n@lists.open-mesh.org, Jonathan Haws <Jonathan.Haws@sdl.usu.edu>

--nextPart13643698.1f5CdSmA7F
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jonathan,

On Friday, August 26, 2016 3:02:51 PM CEST Jonathan Haws wrote:
> On Fri, 2016-08-26 at 08:45 +0200, Sven Eckelmann wrote:
> > You don't seem to follow these rules yet. Instead you seem switch the
> > Signed-
> > off-by: line with the body of the explanation. So a git-am with -s
> > (as the 
> > maintainers do here) would then produce this mess:
> > 
> >     alfred: Adding time_subtract utility function
> >     
> >     Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
> >     
> >     Added time_subtract() utility function to use for simply
> > subtracting
> >     one timespec from another.
> >     Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > 
> > 
> > [...]
> 
> 
> I've backed up to origin/master and will produce a single patch.  The
> "signed off by:" was a misunderstanding on my part.  Here is what the
> commit log will look like:
> 
> alfred: Externalized synchronization interval
> 
> ALFRED_INTERVAL is now externalized via the -p option (synchronization
> period).  If specified as option, user supplied interval is used,
> otherwise the default interval of ALFRED_INTERVAL is used.
> 
> 
> Does that look right?

Yes - and you put your Signed-off after this text and you are good. :)

> 
> 
> 
> > > 
> > > index c5df945..884a1a7 100644
> > > --- a/server.c
> > > +++ b/server.c
> > > @@ -372,7 +372,10 @@ int alfred_server(struct globals *globals)
> > > 
> > >  	while (1) {
> > >  		clock_gettime(CLOCK_MONOTONIC, &now);
> > > -		time_diff(&now, &globals->sync_period, &now);
> > > +
> > > +		/* subtract the synchronization period from the
> > > current time */
> > > +		time_subtract(&now, &globals->sync_period, &now);
> > > +
> > 
> > I'm guessing Simon meant to have the comment in the first patch. I
> > don't get 
> > why you now introduce a time_subtract which is just a copy of
> > time_diff 
> > (without the return value).
> 
> 
> My reading of his response was that time_diff was meant for something
> completely different, thus shouldn't be used here.  Thus I created
> time_subtract.

Sorry, I guess I wasn't clear here. Yes, time_diff was for an entirely 
different purpose, but re-creating the function with a different name is not a 
better solution IMHO. 

> 
> 
> > > 
> > > +void time_subtract(struct timespec *tv1, struct timespec *tv2,
> > > +	      struct timespec *tvout) {
> > > +	tvout->tv_sec = tv1->tv_sec - tv2->tv_sec;
> > > +	if (tv1->tv_nsec < tv2->tv_nsec) {
> > > +		tvout->tv_nsec = 1000000000 + tv1->tv_nsec - tv2-
> > > 
> > > >tv_nsec;
> > > 
> > > +		tvout->tv_sec -= 1;
> > > +	} else {
> > > +		tvout->tv_nsec = tv1->tv_nsec - tv2->tv_nsec;
> > > +	}
> > 
> > Have you checked the glibc documentation about this topic (search
> > for 
> > timeval_subtract)?
> > 
> > https://www.gnu.org/software/libc/manual/html_node/Elapsed-Time.html
> > 
> > This might be relevant when you want to create an function which does
> > handle 
> > more things than time_diff currently does. Otherwise I don't see a
> > reason why 
> > we just have the same code twice in util.c
> 
> 
> Yeah, I've looked at that.  The code they present there essentially
> does the same thing.  I can pull that in and have a timespec_subtract
> call, or I can go back to time_diff with the comment.  Which would you
> prefer?

Both are fine. Either do time_diff with a comment in alfred_server() to let the 
reader know that you are somewhat mistreating the function, or pull the 
timespec_subtract() function in (I assume we can do that, license wise). You 
decide. ;)

> 
> 
> > > 
> > > +
> > > +	return;
> > > +}
> > > +
> > 
> > Why a return here?
> 
> 
> Style.  I never have a function without a return, even voids.  Maybe
> I'm a bit OCD on that point, but I just feel happier seeing it there.
>  :)  Depending on what you want to do with time_subtract, we can remove
> this return or replace the function.
> 

I would prefer not to have that useless return here. :)

> 
> 
> > 
> > Btw. I am seeing whitespace warnings when applying the patches. Maybe
> > you can 
> > check them:
> > 
> > Applying patch #16667 using 'git am'
> > Description: [1/2] alfred: Externalized synchronization interval
> > Applying: alfred: Externalized synchronization interval
> > .git/rebase-apply/patch:89: trailing whitespace.
> > ALFRED_INTERVAL setting of 10 seconds will be used. Fractional
> > seconds are 
> > warning: 1 line adds whitespace errors.
> > Applying patch #16668 using 'git am'
> > Description: [2/2] alfred: Adding time_subtract utility function
> > Applying: alfred: Adding time_subtract utility function
> 
> 
> I'm not sure where this would have cropped up, but I'll double check it
> before I submit the next patch version.
> 
> 
> I'm new to the contributing game - I've read through the wiki, but
> apparently there are other details that I missed.  Is there some good
> documentation on the typical procedure to follow and formats and
> whatnot to read up on?  I thought I had understood everything, but
> apparently not.  I hate to cause extra work for you maintainers simply
> because I can't get a simple patch right.

Don't worry, as long as you are patient with us we are patient with you. ;) 
And I admit we have quite a list of rules. Basically, we are following the 
Linux kernel style, and there are a couple of tools which can help checking 
that (e.g. checkpatch.pl). The good news is, once you do it like we do, you 
also know how to format patches for the Linux kernel (more or less). ;)

Did you read the following wiki page yet?

https://www.open-mesh.org/projects/open-mesh/wiki/Contribute#Submitting-patches

White space warnings can probably be avoided if you use git format-patch to 
create your patch, and git send-email to send it to the mailing list. This 
avoids any mangling of the patch which git wouldn't like.

Thanks for bearing with us. :)
      Simon
--nextPart13643698.1f5CdSmA7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJXznKoAAoJEKEr45hCkp6hytEP/RxZoTJE1Lh1J0+swWSgt60y
E8lSuBcZ5ZwLbAYHWzIw/osZNHMjcTfRFushBxUfkzHPITI6q5dASItKO/i1hFnF
d8RxaG2jcUEkWlV46IhZVcRfGUlfQVYWh7iiFBgKp0wJCMYMBQuTfZxCH+XrLbPz
hOvQuhf8XWrbtKUjgc0oZvBOPyQH5hY+nzfxpWV8dPXDKCB/eEcOMQ0455EygPeJ
HIY6vBxfItVVw4LopSz42udXF4zr1Oc5qOjWCy7ZfD77AtvsuptDy0WL/6lFrL/8
OkEb6nBSt7IxYg8jLf0g3GLkm1dsMl3/gbpS32WKZhyMsaE18FW0Rd0f5Ykuj1u/
BRNfkHCpg3pjfbDGYTuzpC321REPK++Vxe5jX+zFctfmJTd7Mqv/kBUDnAdP67T1
5csEQxsav35dIVxlzSnTnGAYAc1jbThB7xNn8H5qjGWynbyDNjN5h9NzvaGHwePh
hCBrjp0CsIrNJeWOgfYAVqXspSEPEQHuRH6mCAuogqp02bMRtYEWdvNAb4+hM/hR
eOT8fHb+/K/hpTi2GZACPJyzHSomytU+n+srjjgNMZrZWTDD+zFTksxHYBdqvdV9
B3dv79m1j2NdhwTFmf50jzToUMD4P6gp0LVMJj27OLHFOHDnFaquu5PJeEkl8UEj
bEqvUZ5E30yp2uNT/p4W
=Wjdq
-----END PGP SIGNATURE-----

--nextPart13643698.1f5CdSmA7F--

