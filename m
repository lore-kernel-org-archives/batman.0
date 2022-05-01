Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] alfred: notify event listener via unix socket
Date: Sun, 01 May 2022 11:12:12 +0200
Message-ID: <2357978.S02m7aqKFs@sven-desktop>
In-Reply-To: <1831000.Ehg04xY5OU@rousseau>
References: <20220430105647.340588-1-mareklindner@neomailbox.ch>
 <3246469.CvshgyVVUE@sven-l14> <1831000.Ehg04xY5OU@rousseau>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6694723.kCZG3UKmh0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

 
--nextPart6694723.kCZG3UKmh0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH] alfred: notify event listener via unix socket
Date: Sun, 01 May 2022 11:12:12 +0200
Message-ID: <2357978.S02m7aqKFs@sven-desktop>
In-Reply-To: <1831000.Ehg04xY5OU@rousseau>
References: <20220430105647.340588-1-mareklindner@neomailbox.ch> <3246469.CvshgyVVUE@sven-l14> <1831000.Ehg04xY5OU@rousseau>

On Sunday, 1 May 2022 11:10:13 CEST Marek Lindner wrote:
> > > +static void unix_sock_event_listener_free(struct event_listener
> > > *listener)
> > > +{
> > > +	list_del_init(&listener->list);
> > > +	close(listener->fd);
> > > +	free(listener);
> > 
> > list_del_init has no benefit (only downsides) when you free the memory
> > anyway at the end of the function
> 
> What are those downsides you are referring to ?

Additional writes for something which is dropped anyway.

Kind regards,
	Sven
--nextPart6694723.kCZG3UKmh0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmJuTuwACgkQXYcKB8Em
e0ac7xAAixNv1iu2z2g2RZSiQMlttPeE7AGetRNJmBZXhhWAEZV9//Enphge5x6J
G02xJkqgtJdKP8B77CTd5lWhqflqs22PdECjss6nXyGmzuYFjD/gP3uC0bA45ARC
bIF/Kp745mAj6iBQS/fBI/dwkT+NMVoVfr9tI/SBvT4SP0inh28zl2oP156jf/LR
lbtAsiYvb279/Dwo71pCooI3H6PyRausvQ/XmTxESIqM9CKp1d0o3okvPbC5Mkm7
BThMZTLkXWAmlGr7k6vXzZxFXPxO9MC23SDhfzjJGquZeBWf20VXDfvLYQHw5eU/
uAn/uB/prZ/KRUz+djtFrboy7+xv2k0cDJBeU2vlwHTNECfCR7zauD3WjujF8Ov+
s22GS7rG9aGFq914tVgHqmFm0zKkdng9uEqTe2SHZmMzoqRX2KvHcHe4XpHHXtAA
YpvXlXBNmHXnbVz7Wz8r66R3TjM9nej/Ccalt8mFIJcNnPPd8DqbS2FDydgy2I45
zDR9QhdjgitLQk9usgF2kPvcsSy9vZ9a0wkKLbetXl0ty3tuBMAyIXyw7oWOzSE7
Pg+rLtWyk0kxAfTzlSTGyr/EUEib9NjtgA92610g/K8YlvutwOfMU0BljCkv0hwc
xqbcJ5Xx3ENMstJdtqAdXPcSHbAI6RTTZdnH61MFjjkirF/AMa0=
=03aU
-----END PGP SIGNATURE-----

--nextPart6694723.kCZG3UKmh0--


