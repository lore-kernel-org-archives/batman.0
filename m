Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Aug 2016 09:17:17 +0200
Message-ID: <4649649.ZYgmAyi5E7@sven-edge>
In-Reply-To: <1472223771.12832.15.camel@sdl.usu.edu>
References: <1472157596-19774-1-git-send-email-jhaws@sdl.usu.edu>
 <1663649.BbZ0OMDasJ@bentobox> <1472223771.12832.15.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10159219.8Q3mOxuybs";
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
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart10159219.8Q3mOxuybs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 26. August 2016 15:02:51 CEST Jonathan Haws wrote:
[...]
> alfred: Externalized synchronization interval
> 
> ALFRED_INTERVAL is now externalized via the -p option (synchronization
> period).  If specified as option, user supplied interval is used,
> otherwise the default interval of ALFRED_INTERVAL is used.
> 
> 
> Does that look right?

Now the "Signed-off-by: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>" is missing
at the end. You should check out "11) Sign your work" [2] to understand why
Linux related submissions tend to have this line.

The reason why it must be at the end was shown in my last mail. Tools like
git-am or git-format-patch can automatically add the Signed-off-by of the
person who accepts/forwards the patch - but only does it at the end of the
commit message. So you Signed-off-by should also be at the end of the commit
message.

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
> > I'm guessing Simon meant to have the comment in the first patch. I
> > don't get 
> > why you now introduce a time_subtract which is just a copy of
> > time_diff 
> > (without the return value).
> 
> My reading of his response was that time_diff was meant for something
> completely different, thus shouldn't be used here.  Thus I created
> time_subtract.

My reading was that Simon wanted just a comment which explains what is does 
(because it was not intuitive to him).

@Simon: can you clarify it for both of us? See also the following question 
from Jonathan:

[...]
> Yeah, I've looked at that.  The code they present there essentially
> does the same thing.  I can pull that in and have a timespec_subtract
> call, or I can go back to time_diff with the comment.  Which would you
> prefer?

(see above)

> > > 
> > > +
> > > +	return;
> > > +}
> > > +
> > Why a return here?
> 
> Style.  I never have a function without a return, even voids.  Maybe
> I'm a bit OCD on that point, but I just feel happier seeing it there.
>  :)  Depending on what you want to do with time_subtract, we can remove
> this return or replace the function.

We prefer not to have a wasted return [4]. But lets wait for Simon's answer
regarding the extra function.

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
> I'm not sure where this would have cropped up, but I'll double check it
> before I submit the next patch version.

Looks like following line in the manpage has an extra space at the end:

    +ALFRED_INTERVAL setting of 10 seconds will be used. Fractional seconds are 

> I'm new to the contributing game - I've read through the wiki, but
> apparently there are other details that I missed.  Is there some good
> documentation on the typical procedure to follow and formats and
> whatnot to read up on?  I thought I had understood everything, but
> apparently not.  I hate to cause extra work for you maintainers simply
> because I can't get a simple patch right.

batman-adv is a a kernel module (included in the official Linux kernel) and
thus we have to follow the linux kernel coding style [1] and submission 
guidelines [2]. The batctl and alfred patches use the same style and we want to 
have patches have submitted the same way [3]. But we don't tend to enforce 
everything for alfred/batctl because these patches don't have to be forwarded 
to the next "higher" maintainer. But odd things will still be pointed out. And
they will also sometimes result in rejections but this depends on the
maintainer and level of "oddity", 

Kind regards,
	Sven


[1] https://www.kernel.org/doc/Documentation/CodingStyle
[2] https://www.kernel.org/doc/Documentation/SubmittingPatches
[3] https://www.open-mesh.org/projects/open-mesh/wiki/Contribute#Submitting-patches
[4] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl
    search for RETURN_VOID
--nextPart10159219.8Q3mOxuybs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJXwo/9AAoJEF2HCgfBJntGQFoP/Rllm3VB/jOIXuXn/PXkv90U
+4g3e753wtMgza2iB6LmnNUBS0XwKNNBFRPe0jPHbdTXESvwV2cQVleMUXMd3jVm
l7Of1n5Dus/GbSTeFvXvN0fKScsvg3GOsz0kNVPiXwZUPd6fLUP8v19UulzTy+cY
TJXKfXPMkfaNwXF6+vtUEv2Fw0MfKNOytU5ygP9MS65xb93pJPO0oMdMPJ783Eyb
kJYb2GzLWdxdM6GkL8vcaqLt8V6+ogfNWRGIVWOCwTcFkQcxevgY8qQEjH4MT23p
MLJvQCDOEVfrd0jABTcxaw/Mzq1Aq76DR1qTsa8n6lfVLFoLj0PPWI0TLjzUD8Nh
LuenSojwoRFVxbH84+1u0hN4U7y5YQljgPnjThq8pOBwx3CE6mtmsPx+6GLpvDJT
S+elB3v0hX0mvwSLHztxn79AsZIWSKCd8P7nk1GUClTxa093daXPDY6SZr8VVXWK
OPs4545Rmv7CdGK9+wcRxakXRT9Yqh+n4N6e3ltE9s9NAXGfNCVrNoWltMTVdfGq
BpSJkdLLHBSKO3pVyvu/7av3djhV7suykOQLOYUqjVVlkCR56WUvdrwsGH0tr9dY
PYo72L7iu6mIX73T3YsRKdrGlGDOrb80Q+6WjIxgg6Dog5PxOfmbxfvdBs1ZwzYT
bWpM1lcEdFQHLqPbVkjj
=SPHf
-----END PGP SIGNATURE-----

--nextPart10159219.8Q3mOxuybs--

