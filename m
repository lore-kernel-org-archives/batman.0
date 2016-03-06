Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 06 Mar 2016 09:55:33 +0100
Message-ID: <1718376.7aKDD05sGf@sven-edge>
In-Reply-To: <20160306000823.GB1976@lunn.ch>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <20160306000823.GB1976@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2170473.TaTxVnKpjX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Check hard_iface refcnt
	before calling function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2170473.TaTxVnKpjX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 06 March 2016 01:08:23 Andrew Lunn wrote:
> Hi Sven
> 
> Thanks for the patches. I will test them out of Monday and let you
> know if it fixes the crash.

The ones I've Cc'ed you are not really about fixing the crash. They are just 
to clean up the reference counting (which you've complained about). You can 
test them but I would doubt that they fix the problem. But they might help you 
to detect situation when the refcounter gets 0 but shouldn't.

There are also some related problems which I've already mentioned on the 
mailing list 9 months ago and never got an answer. I've moved them now to the 
issue tracker in hope that the authors of the feature will now reply. The 
unchecked double *_put with [2,3] together with the unchecked double list_adds 
[1] are a good way to mess up the reference counting of several objects 
(including the hard interfaces).

You may also want to add a real reference counting fix which I've also posted 
yesterday (but for non-hard-interface objects) [4].

And a small remark about your x86 without serial port. Two systems connected 
via usb-serial+null-model-cable+usb-serial work quite well for this type of 
tests. Add  "console=tty0 console=ttyUSB0,115200,n8" to the bootargs of your 
test system and boot it up. The system used for gathering the kernel output 
just has to run "screen /dev/ttyUSB0 115200" and dump all the data.

Just a suggestion in case you didn't think about using this kind of setup.

Thanks for debugging this problem and have a nice weekend.

Kind regards,
	Sven

[1] https://www.open-mesh.org/issues/243
[2] https://www.open-mesh.org/issues/242
[3] https://www.open-mesh.org/issues/235
[4] https://patchwork.open-mesh.org/patch/15888/
--nextPart2170473.TaTxVnKpjX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW2/CFAAoJEF2HCgfBJntGwU0QAMgVy1c2eKjjrUgLuFjoZ/31
zcxElr0S0MT1m9u4Koi5xITg50EoING88wSIKIFF4vWkt3+cw9eWZHSS3yZmhht+
KyuLXfDz2CLJ95r6VKYRRLNTeKo5icoU9NUxhakIRC/IJ8zcee+8FQcQc47x6xJ+
kTER2oZft0EfVGS4QE1asIeJCsz3nTD7UTyyla9RHnTt8oDZBG/ebNQHHzGOM0g4
dbjoGfqGfsnmGI6HpZdUBzIoiutTOBTXqC6OjX9qS6ox+5LyDdSf9dL0LM+YNIFZ
kWDYzgOVIHqCQePmiu8ZTPG8BQo+bxvzBLXRK7Vs1b3Y9CUciPaWERl67GNMl8zA
oMupyKWTJpi5IumzM5JsSs8Dk7FuAFYesrrfW5kTJ/VCB6A8X2nmXVy/feCuHRQH
Du3qx8XOmsg8sqAHw9fodGesmLx5HoPzgGVpes/7NncCdDZ3FB1WmYuIceMoSVHH
8DtZGtaEl7RwPogInDJBTnzeKLDTkwDraLARv4TuY4kYZ1yq+LzjBx+oVhMNaFqS
LokUQ51717NO8but/ThiejYTZxEQ2vp9wf6hFNCRenwHSei9gtTK1BergFBDSGFU
dG0JBtbCBCJ4zqi9OXle3r98cyUtvrOPv+kbBVR/8mC6AUKM5wIqOq6qKFHj6DLG
q5SUh0RfpWxq1xWQ4j81
=HhFG
-----END PGP SIGNATURE-----

--nextPart2170473.TaTxVnKpjX--

