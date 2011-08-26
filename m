Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Aug 2011 22:14:02 +0200
Message-ID: <1802641.DqNRxioE9k@sven-laptop.home.narfation.org>
In-Reply-To: <CAA4cjYAbJCZy1jT0-s9J+cygEFD=jFb1ocLKeG4WgZe6GvxruA@mail.gmail.com>
References: <4E55724D.5000405@linux-migration.net>
	<20110825055158.GA27922@sven-atom.home.narfation.org>
	<CAA4cjYAbJCZy1jT0-s9J+cygEFD=jFb1ocLKeG4WgZe6GvxruA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1457689.ZKJu90eWdj";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Comments on Lifenet?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Hrushi Mehendale <hrushi@gatech.edu>
Cc: "Vempala, Santosh S" <vempala@cc.gatech.edu>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, jon roland <jon.roland@constitution.org>


--nextPart1457689.ZKJu90eWdj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Friday 26 August 2011 15:32:37 Hrushi Mehendale wrote:
> Hi Sven,
> 
> Thank you very much for your frank comments about the code.

Another comment about your mail: Don't send html to the mailing list... it 
will be dropped.

> Hopefully, with help from experienced programmers such as you and many
> others whom we may not even know, we would be able to improve the code
> quality. The prototype is just out of our research lab and as you pointed
> out, the code needs to be fine tuned now. Apart from building the prototype,
> majority of our efforts have been spent on porting LifeNet across different
> hardware and OS platforms, in order to validate our baseline claims of
> hardware and OS interoperability.

I doubt that it has something to do with fine tuning. There are just simple 
things which you should not do: For example accessing memory after you free'd 
the memory region.

> Do you have any suggestions for us to facilitate better interaction with the
> community, particularly to make sure LifeNet adhers to best programming
> practices / standards?

A nasty comment would be: learn coding

But honestly, you should get in contact with good kernel programmer which can 
work for you. It is not a "community" thing, but understanding what you are 
actually doing. I think those papers are a good example. You seem to 
understand your problem and try to find a solution. But the problem is that 
you are not the persons which understand the actual implementation stuff. So 
maybe there is a operating system department at your university which has 
experienced people and can help to implement your ideas.

Not that I have a problem with research code... but selling it to 
organisations and knowing that it has ugly bugs seems not to be a good idea 
(at least from my point of view).

Kind regards,
	Sven
--nextPart1457689.ZKJu90eWdj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOV/6KAAoJEF2HCgfBJntG7rkP/Au+QEg5uksBtPkJu6W3mXi+
bIets/fBSGH42J3OvA9xbhajLTLYHL1+TVXBlH2tx3nNI3fJq92REa0Jz13k5PEx
KrCyOMT2svxaBmwH8Mdvh2/QhvK4+s8dBAyg6N+pJAGc1shPrEEj3ipyrWDK3xEr
0DC1JGMqXr/TDuOF2JvaupD+JHdi7M7/pqKg4Nz2u59mrVTcFf/KuD7+pgi2wSuE
O/RRmwvVUFm6YDHlDIJH1MgV5rb5C+i7vT7XMVgqbviwjMYZFMBWZBgOJOO/UCfA
TdzLjkXrfMB7Mgz354C1gywKMmQQvm/x3LQpSlqW2qiNeoJA+TwXOWgoywgKM1xV
oc5eI/30jcVeRJqQZo2gOsF9Oi03e/HELsISbWavRuj3KGVk6MghBto24qhkoEB9
c4N9PNVtW1y0aqlRTlyvl2AABvrtbBVJLhJYRkcljiOjGAe9DtRhlKoKtXIFWaXN
CxBNRJgTE7IkrZ9LIDcOZdhRT74emCiPuwi+6zlQIKrxf5D97Djm7081fmtjGLs+
m1A2RbkRQ7HUNMpNeTkk0SSBWJbUXpfn9zDDIB8KV1N6QXVk4A/uT9j+HFRUedrk
kqer6Rf1xYN9075nu6+KrdBuNVCNrZ0XaPBPLqUCEzHhtMeV71ONlqFVoWpn8MZT
POemiU8k8qT0/EfJt40i
=upuX
-----END PGP SIGNATURE-----

--nextPart1457689.ZKJu90eWdj--

