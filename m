Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 12 Aug 2015 08:44:53 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB7939D@AcuExch.aculab.com>
References: <1438779107-12665-1-git-send-email-antonio@meshcoding.com>
 <1438779107-12665-3-git-send-email-antonio@meshcoding.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB737B7@AcuExch.aculab.com>
 <55CA2605.1070201@meshcoding.com>
In-Reply-To: <55CA2605.1070201@meshcoding.com>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: fix kernel crash due to
 missing NULL checks
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Antonio Quartulli' <antonio@meshcoding.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

From: Antonio Quartulli
> Sent: 11 August 2015 17:43
> On 05/08/15 15:15, David Laight wrote:
> > So is this test just hiding anoter bug somewhere??
>=20
> Hi David and thanks for your feedback.
>=20
> The point is that we got several bug reports of kernel crashes due to
> NULL pointer deferences in these lines and after having debugged this
> problem for quite a while we preferred to move on and propose this patch.

That is what I thought.

> Still, I am personally debugging this part of the code to understand if
> we really have something wrong or if this NULL pointer is something we
> should expect (and therefore check).
>=20
> For the time being we think this patch is better than having horrible
> kernel crashes, but I hope to come to a definitive conclusion soon.

If you don't know why you are seeing the NULL pointer then you are
just papering over some cracks and it is likely that something
is really badly wrong somewhere (ie missing locking).
This could easily mean that there are some much harder to find
bugs lurking there.

	David


