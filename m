Return-Path: <David.Laight@ACULAB.COM>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Nov 2012 13:36:54 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B70BB@saturn3.aculab.com>
In-Reply-To: <1353499919-28596-10-git-send-email-ordex@autistici.org>
References: <1353499919-28596-1-git-send-email-ordex@autistici.org>
 <1353499919-28596-10-git-send-email-ordex@autistici.org>
From: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Use packing of 2 for all
	headers before an ethernet header
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
To: Antonio Quartulli <ordex@autistici.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

> All packet headers in front of an ethernet header have to be =
completely
> divisible by 2 but not by 4 to make the payload after the ethernet =
header again
> 4 bytes boundary aligned.

I'm not sure that statement is correct - whether the patches are
correct rather depends on the actual packet format(s) you are
generating/modifying.

If you are adding data to an ethernet packet you'll need
to add a multiple of 4 bytes in order maintain the alignment
of the IP header (which needs to be 4 byte aligned and is
usually 14 bytes from the start of the receive data).

This means that the data you add probably has to be 4n+2
aligned - since I guess you are adding between the source
MAC address and ethertype?
If you are inserting data after the ethertype (ie after some
protocol identifier), then your header can be 4 byte aligned
provided it ends with the replacement ethertype (0800 or 0806
for IP protocols).

	David



