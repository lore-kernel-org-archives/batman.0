Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Jun 2015 19:23:55 +0200
Message-ID: <7394365.ZOVSlEK3zK@bentobox>
In-Reply-To: <1433072160-3260-2-git-send-email-sven@narfation.org>
References: <1433072160-3260-1-git-send-email-sven@narfation.org>
 <1433072160-3260-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2839213.sjIxP4J1WI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/6] alfred: Make buffer size check
	before sending explicit
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2839213.sjIxP4J1WI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 31 May 2015 13:35:56 Sven Eckelmann wrote:
> It is checked when data is send by checking if the data would fit inside
> the outgoing UDP packet. But it is not checked if the data would fit after
> the sending was done. This doesn't have to be true just from the
> restrictions which can be seen in this function. So just check if the data
> and its headers would now fit in outgoing buffer before copying the data to
> the output buffer.
> 
> This is not a problem by itself because the data + header in the dataset
> cannot be larger than (MAX_PAYLOAD - sizeof(struct alfred_push_data_v0)).

Alternative commit message:

The sending code is automatically transmitting a packet when the next data
block would not fit inside the outgoing, aggregated UDP packet. But the
code does not check whether the data would then fit inside the new,
complete empty push_data packet. It is currently no problem because alfred
has the restriction that a dataset never stores a buffer larger than
(MAX_PAYLOAD - sizeof(struct alfred_push_data_v0) - sizeof(struct alfred_data)).
Therefore, the length check for the empty push_data packet + dataset buffer
would never fail.

Nonetheless, make this check explicit to avoid problems when the receiving
code is changed or the sending code gets the ability to limit the size of
outgoing UDP packets.

--nextPart2839213.sjIxP4J1WI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVbJUuAAoJEF2HCgfBJntGHiAP+QFzQh3waA5Y2//xXL5xhQfS
5F10J50bpcHgaCi02Vzss0TPMSWmdx82iVGeEaw39dlcYniv0S2nTVUqhnI6twiQ
qGAPRhTZDSVWsb55BaRa9FYvWbRim5k65cM+Zufy4QVbjxYiGZp3FnA8XfmtVaXo
tlQW9gf8Zvsgg9E2bWrMtYm40NTuy783ngWBOa+a9uuUAPa9vqzzT9YBINNqVh7+
OaSkl6CEItUT4hASfU9pFXQSsGzZ29AycyUIibNZioLcICGkRrzwHBS2yhRL3I5A
zoXj4576/LnffJSvsVW3hM8+sEbBEaoXn+t1/qG8rUQdmRELx6JLPasDlbBfLC1O
/W7QfZbhXcl9SHsdlXl9/ZwfrVYVBjK10YLqqw7ilC9Hx6e74a4EDs2kAZ5aUPcq
XxIFYtK1vNlacb6BVpzmne5l7/XYOWScNY7r6kmjV7UER/Gczs+N8q9KrUBb7B7w
CC00aIV0p/RKXsMynrjrcD0SCt3UhtLwb1q3ahHmlMmGEl7SF1rnxetGjhWp8Pko
a8Rx6yM+eM/Py1iPWkwT/lHD+0K4cxBwbptPv3SIWsx2MJug1ajR5swtWkjQKID3
h3P+OysBdxJCJVK9hXblyxa9i+7+JmNmTR9OIc4JyrzlBN2QMmHSJhCUBnF0zsb7
qCcFwjQKvbZacsx1OonQ
=iaiV
-----END PGP SIGNATURE-----

--nextPart2839213.sjIxP4J1WI--

