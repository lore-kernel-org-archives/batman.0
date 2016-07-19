Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jul 2016 10:41:31 +0200
Message-ID: <3103042.h6R1kj0P7L@sven-edge>
In-Reply-To: <1468597173-25378-18-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-18-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2660330.B5q3U1AySM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 18/18] batman-adv: Place kref_get for
	tvlv_container near use
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

--nextPart2660330.B5q3U1AySM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 15. Juli 2016 17:39:33 CEST Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type

s/tvlv_container/tvlv_handler/ in subject.

Kind regards,
	Sven

--nextPart2660330.B5q3U1AySM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXjee7AAoJEF2HCgfBJntGOIAP/it9nyywyxZvNm+6Y8AQJO22
RkmY3EgltZgHXgPjJXAXTqgSdhcMx5XPtNgHsfdjQMSHA+M71M8RrFH5dJqPV0pe
hzCsoScTi9nlkR6HoT7ggReC/WnCc8nqy6fKm/KcbiBsprd4VHxIl5Jd7hfTNzih
xWp6Xh+oUVsnaDbT543J4evfRvPWoyJyOd2VSJhzziMIlFokxx7F9Ib4XPxRgPXo
xlhqHW9P3NvEMEzCVB2oEhshdGHzw2JUoql93bycOTAXhUkoJ41zeMsat+B1wmrq
jwaVzsFNUeaHhJqNabK5SboM0zkAnRSdcb56qPw8ILNbNw9Wd+Ssf9lQrmswdfQa
o+KdnmP/UNEjiTJyVf9P5A8+snxUPRFDZ7nwv8zyAevfZ84D4pRWWJKmtIW5mS6a
fLKFMudlWfzyjby0qGTtydWg6WvLG0XYzG10INJgt9jpcJFxr/Id0Uk6+r7ZtA4T
HzRZlodMrw5Z0YzQjC4yZ6IEspN6RG+FhGT51JZLWXODjb5wuc/CJDBiwzwyvPvk
+UEeBfcN2MqelYps+lUKZ3K3ABUIB980TOR4JHkTwW98HJKxOHSTTv3FeQ2m6E2j
FILx8bFuZkriuQfvi9vQK/88EXBEu8cGgT5O7XTMkvLUJHAAU8xh5vqaGZcQEYMl
Fb7wR3hUqxtStrFTQbCD
=gpoj
-----END PGP SIGNATURE-----

--nextPart2660330.B5q3U1AySM--

