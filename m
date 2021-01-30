Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: batman-adv: User defined nonce in packet header
Date: Sat, 30 Jan 2021 15:01:28 +0100
Message-ID: <50377703.RPh4jNDbgB@sven-edge>
In-Reply-To: <5928700.sXXJehETrP@sven-edge>
References: <CAJZjC1surX81hwZLchC6jfETiFGE9F1tZbUJKhbbwE7Q5UOqXQ@mail.gmail.com> <CAJZjC1sCQRd_QBYcaQUWADTjgA6FBp0qshhUxrmw9tXkjYKu3Q@mail.gmail.com> <5928700.sXXJehETrP@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8531407.V59q01m9Al"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Moullick Mehra <dedamamoge@gmail.com>, Tushar Malpani <tusharmalpani20@gmail.com>

 
--nextPart8531407.V59q01m9Al
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Moullick Mehra <dedamamoge@gmail.com>, Tushar Malpani <tusharmalpani20@gmail.com>
Subject: Re: batman-adv: User defined nonce in packet header
Date: Sat, 30 Jan 2021 15:01:28 +0100
Message-ID: <50377703.RPh4jNDbgB@sven-edge>
In-Reply-To: <5928700.sXXJehETrP@sven-edge>
References: <CAJZjC1surX81hwZLchC6jfETiFGE9F1tZbUJKhbbwE7Q5UOqXQ@mail.gmail.com> <CAJZjC1sCQRd_QBYcaQUWADTjgA6FBp0qshhUxrmw9tXkjYKu3Q@mail.gmail.com> <5928700.sXXJehETrP@sven-edge>

On Saturday, 30 January 2021 11:06:10 CET Sven Eckelmann wrote:
[...]
> The information are far to vague to give you anything.

I just got two mails which tried to standard new threads and were therefore 
rejected. Still I am forwarding the most relevant one of both to this thread.

But I still think that this is completely unrelated to batman-adv. Because it 
is at the completely wrong layer, doesn't have access to the users device
(and the other way around) and  the firewall wouldn't even see batman-adv packets:

----------  Forwarded Message  ----------

Subject: Users authentication with roaming feature
Date: Saturday, 30 January 2021, 14:18:02 CET
From: Tushar Malpani <tusharmalpani20@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,
     I have a community mesh setup here in India and we have been
using B.A.T.M.A.N  Adv as our mesh routing protocol. At present, we
are using pfSense firewall/router which hosts a captive portal for
authenticating a users. Am not sure but somehow it seems to work great
with client roaming as the users switches from one node to another
but, since it's easy to bypass a captive portal by changing one's IP
and MAC address we switched to different authentication methods such
and tried using WPA-Enterprise, VPN but none of those gave us a
seamless roaming experience.
So, we moved baked to captive portal as of now and understood it's
working and found that it uses ipfw table under the hood, it adds the
authenticated users IP address in ipfw tables and passes all the
request made by them.
And then we came up with the idea of adding an additional header to
each packet which will have a value(which is unique to each
user).After the first authentication we add that unique value to our
firewall rules which will be similar to what captive portal does but
secure since each value is unique to each user.
Can this be done by tweaking B.A.T.M.A.N Adv code or this is something
which should be done at users devices?
Is this idea as good as we think it is or there is already a better
solution out there?
Can you help point to where to look, learn and build this system?

Thanks and regards
Tushar Malpani
-----------------------------------------
--nextPart8531407.V59q01m9Al
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmAVZrgACgkQXYcKB8Em
e0aU1A/9HSxtJWGtshft1JewWUy9Z1IW8FOnIzj+BmgQYGcIxiwFzlIG6rcII5HX
smybmxfijK34ffdmcKF6TulJ0d2y0Buuihpmf7T7/Xz/hKD6fNgeVvS3pKct+Tka
tzBHW1eERItl+qwoLgd0F2B+0w7xlxuIybgx/bxpHz28pQQ7wMMhMhlJCGrnoQjT
Fqp2RdWH1dlxqi2fbBHZc/DgqZ5ntsPPeoAbTcpCMwlt0MUrN4NJwN3w5dGrIXsx
0+tHluy2N+OkmI99hEXqt36FSQ4yRf35+6wMEcKCqxUmW0WI/+bymeMCSiEIiXh2
BAoA8UeefdvYZQAkkWFKiHMvA77Hy+yg4EujMIk3KZ1McKTxsWo2KEoA0P0uSHsm
GNL4i9nO5ukHXRfQsE8QVKoaPyWjKN9IdPPB9oL94OHxbd2shgmTqXE2WMILmcF1
UPAMm4oAXJz4yeShQx3dXujlL+b/PA0ArVPcNyt1u8GxNTPGx2rxCzhS0V9pVopX
VTXX4oq8tjN04sCregKzEWcZ3IRlo+DaDuYYOGK4Qx6H95Pvyl79cqCvgEoS/TXa
1nj9fRzVCISzjle36rq/ronlWVRsZyUyhHICnlUY4J1cRdsvHY92AhF8X1nKM9pB
Wav4QYeG77YMZpUnSzBjWEMtUX0YOee8ELiqHGWAv6PEfsmgrcs=
=KPeP
-----END PGP SIGNATURE-----

--nextPart8531407.V59q01m9Al--


