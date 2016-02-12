Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 12 Feb 2016 18:36:46 +0100
Message-ID: <4010815.oxNa1dpjBe@sven-edge>
In-Reply-To: <OFD4FAC06D.50E7ADCE-ONC1257F57.005D7B39-C1257F57.005FA7D8@phoenixcontact.com>
References: <OF514CE6A6.70ACFF1A-ONC1257F57.004BE44C-C1257F57.004C213B@phoenixcontact.com>
 <4371963.A8XJeSUaCP@sven-edge>
 <OFD4FAC06D.50E7ADCE-ONC1257F57.005D7B39-C1257F57.005FA7D8@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2485172.ag3Y7L6D5D";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: [PATCH 1/4] batman-adv: Prevent
	mutliple ARP replies sent by gateways in bla setups with dat enabled
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andreas Pape <APape@phoenixcontact.com>, b.a.t.m.a.n@lists.open-mesh.org

--nextPart2485172.ag3Y7L6D5D
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 12 February 2016 18:24:50 Andreas Pape wrote:
> Am I right that the problem comes from the e-mail client I use? Or is
> there an issue with the patch as such (i.e. how I created it with git - I
> tried to follow the description on open-mesh.org)?

It looks like your client in corrupting the patch. The first link should 
explain how to configure some clients. Maybe you can follow the steps to 
configure your client.

> I conclude from the
> error message in your mail that it's more likely  that I have become a
> victim of my e-mail client.... If this is the case, I will follow the
> advice given in one of the links you refered to and send the patches to
> myself first and try out if they can be applied first before I make a
> second attempt to send them to the mailing list. Unfortunately I'm not
> allowed to use another e-mail client, but I think I can squeeze some
> settings for pure text e-mails (like automatic line breaks).

Usually the easiest way is to use git-send-email. But this would be a 
different email client.

And let me guess, you have to use your phoenixcontact.com mail account to 
contribute to projects... If nothing else works then maybe you can send it 
just as attachments. It is a little bit ugly to comment on attachments but 
better than no patches at all. (I hope it is ok for the maintainers)

> Sorry for spamming the mailing list with nonsense....

No problem. I've send more nonsense to the list than anyone else :)

> Just for my curiosity: are patches automatically applied to a repository
> if I send them to the mailing list? If this is the case, I didn't know. I
> would have been more cautious otherwise.

No, the patches are not applied anywhere automatically. Marek will go through 
the patches and apply them manually after they were discussed on the 
mailinglist.

Some projects use a tool called patchwork that gathers patches but even then 
it wouldn't be applied in a git repo automatically.

Kind regards,
	Sven
--nextPart2485172.ag3Y7L6D5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWvhgvAAoJEF2HCgfBJntGWrEP/RpwBXq5AVAKhqvjDvHTjKFv
2ZU2gxe5gy1AatYOHk5vrqMyMA+1lnoOwl7y1QRWr+CcwQ+hZq38aLECtT3xmWE4
h0sIX1TYkLAc8TnRdEKbAKgWNV3Phduxl9zP0EzI5oWKevzOVPbIoi5M/V0Us41x
TLoxEpWj+U+ABXMvvuN54EgPmimhZPcTs9uv0O9GwsApeea6tz5WvWqzpXFtke3D
hzIsaI+kc6aY4O9pkob8wNGvDpg4bLS2H7n4lo6/KZyvMmf1ohLwJ0JFnHBQ/WOA
a571btJ+J2nNTDbk1+6Kd1cAuT//tjHdpPe/MGjWQJcPSh+adqDDWyHKAw+cJ8tB
GZ6hDtVOUhGBIjNQXc7m/pW2a6SrIU3DCVetTETQ2y+ZOVHGm2uxtuJCUj18sGpS
/PWGsNpp68gvZ54XFSYsvpo2z64X3SmTif+CxzUwcxOY8KEluTRAP3amU73+doBt
Ng354HyzSUHn99duwQxbGRzSUHa6jsLAoVIVFYOlM3H/gIscaXPw1jj3y+IcNxsG
hu9XjTIndmb+/w7fgxooMftaoeVChSZQnl8mN7n76tZQyP9Syx4e2jAaq4Ls4xe9
eYk8nl3bIQP7yqSIEQfJuncp5Wje68Gg+w1836gZGG99pDJWnx1wHBCOYPftE0vp
HUbXBQJvdqeTdE4MoJyN
=+Pgv
-----END PGP SIGNATURE-----

--nextPart2485172.ag3Y7L6D5D--

