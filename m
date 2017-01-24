Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Jan 2017 17:19:10 +0100
Message-ID: <3070960.mqftVVOrFf@bentobox>
In-Reply-To: <1485272132.2398.4.camel@sdl.usu.edu>
References: <1484884864-7315-1-git-send-email-jhaws@sdl.usu.edu>
 <1899098.CrQhkxgaNY@bentobox> <1485272132.2398.4.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4840239.eGQX88PUc7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] alfred: IPv4 multicast distribution
	support.
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

--nextPart4840239.eGQX88PUc7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 24. Januar 2017 15:35:33 CET Jonathan Haws wrote:
[...]
> > This doesn't seem to belong in this patch.
> 
> Yes, that is correct.  I must have fixed that formatting when I was
> going through everything else.  Would you like me to take it out of
> this patch?

Yes

[...]
> > > 
> > > +
> > > +	interface->netsock = sock;
> > > +	interface->netsock_mcast = sock_mc;
> > > +
> > > +	return 0;
> > > +err4:
> > > +	close(sock_mc);
> > > +	return -1;
> > > +}
> > > +
> > You only close sock_mc on errors but not sock?
> > 
> > And please chose something better [1] than err4.
> 
> I see why you'd want me to rename the goto - however it was chosen to
> differentiate between the err goto in netsock_open.  I called it err4
> since it is for the netsock_open4() function dealing with IPv4.  Would
> err_ipv4 be better?

How about "err_close_sock" and "err_close_sockmc" or something like that?
You will need two different ones and these describe what will be done
on errors.

Kind regards,
	Sven
--nextPart4840239.eGQX88PUc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliHfn4ACgkQXYcKB8Em
e0a7ow//cI1+5dKaGneQzwv65OrRhRcWfCKhZ8r1Nf8ak5SlfgmX3sSuuI7GNaB6
bryaj0PKJYBK2MDpixJ6KPZdm5Rfc3R1MsGwBfdxWA8hnt4ZstoqmG8/n8sTJJqp
A/UJYod2OSfs8a65o/uXw1URuhXikcfxQASSfK9Qf/iRfpsWUwhO4O6jy/WpH/5G
Y8wKhJdNSEIsUBqnAqgCx0OQIR/PyePM+hPcTrczURzYcAYpd9LgRZczI84aBURY
pnM2i44uhBrVXkr5uMPUNXcCU9+5EGAvk31tULB5nhzDAflg6F3WBPz+06rV7+om
CL3ZRLIqX6+2Cc3+7fYNz8qxjcrjupUR5Qp3ieNx6FF9t370+GhOjqt3i9nGWhgS
ZeqEoNaaeIaoiPSxZwg5s1dQyg4hrrb0fba6ntPeGHOxRnxRXxsHSE04UEwaMaz0
RwEeyL0n+qXhHoSHCmTj4CJfV8yl4D+tVgsCNnqo8evfna0nYS16XT9+e9z79mgx
WPLZH993TWLqfsEVC2NEN6AsDTB9hVRpedOwxh/nO1xpxzdl4TkuBvlXRdbm78HB
VW7VeCVrekzrEOC00TPsJpn55cUDxqmvXMI/BqnivlljKMJ8cFgWzpAasPrL358q
5cYsbXYCQBaCbEjW1/J/IEEPLqOgXzD9K8CQLo1QwHd/vCzLOik=
=YpBb
-----END PGP SIGNATURE-----

--nextPart4840239.eGQX88PUc7--

