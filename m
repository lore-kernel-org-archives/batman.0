Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 10 Oct 2013 14:58:57 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20131010125857.GA31659@pandem0nium>
References: <1380899775-25238-1-git-send-email-andrew@lunn.ch>
 <70C9D015-5815-4EDA-A427-F496906D18EE@dymos.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <70C9D015-5815-4EDA-A427-F496906D18EE@dymos.org.uk>
Subject: Re: [B.A.T.M.A.N.] a question regarding ALFRED
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello Stephen,

On Wed, Oct 09, 2013 at 05:34:00PM +0100, Stephen Thornton wrote:
> I am currently developing a mesh router solution for several clients. I have been using batman-adv in this project for almost a year (using OpenWRT), and it has all worked fantastically. Thanks so much guys.

thank you :)
> I now have a requirement for GPS logging functionality, along with passing other data between nodes. I have already written a simple layer3 protocol for this purpose, but this was before ALFRED. ALFRED provides almost all the functionality I need apart from the fact that I really need to embed the alfred code within my own application. I could use it as is via a sys call, but it would be so much better to include the code. What are your feelings regarding splitting the alfred code into a library with can be included in other user applications, and an alfred client program that uses this library? I'm quite prepared to give quite a bit of my own time to doing this if you like the idea.

Well, the alfred binary does quite a few things and relies on being a process on it's own. I don't think
it's easy to integrate that functionality in a library, and it is not intended.

What we'd like to encourage however is to interface directly with alfred by talking to it through
the unix socket - have a look at vis (already implemented) or the gpsd support andrew recently
proposed. You could do the same for your application - talk to alfred directly. That should also
be the best solution in regard of long term maintainance, license issues (alfred is GPL after all), ...

If you feel that alfred really needs to be binary-integrated in your application, I'd like to know why. :)

Cheers,
	Simon

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJWpJEACgkQrzg/fFk7axZdCgCff+9IqsUP+GDblIFqZh+pA5S8
GN8AoNLXdoWox6B5VOe9SdHveyrC0tGV
=CFJP
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
