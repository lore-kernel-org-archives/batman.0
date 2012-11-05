Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 5 Nov 2012 09:15:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20121105081540.GA3657@kroah.com>
References: <1351976110-3671-1-git-send-email-ordex@autistici.org>
 <1351991127-10420-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1351991127-10420-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 stable 3.5] batman-adv: Fix broadcast
 packet CRC calculation
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, stable@vger.kernel.org

On Sun, Nov 04, 2012 at 02:05:27AM +0100, Antonio Quartulli wrote:
> From: Linus L=FCssing <linus.luessing@web.de>
>=20
> commit 7f112af40fecf5399b61e69ffc6b55a9d82789f7 upstream.
>=20
> So far the crc16 checksum for a batman-adv broadcast data packet, received
> on a batman-adv hard interface, was calculated over zero bytes of its
> content leading to many incoming broadcast data packets wrongly being
> dropped (60-80% packet loss).
>=20
> This patch fixes this issue by calculating the crc16 over the actual,
> complete broadcast payload.
>=20
> The issue is a regression introduced by
> ("batman-adv: add broadcast duplicate check").
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>=20
> Sorry, but I made a mistake in backporting the patch to 3.5. Now it's ok.
> Thanks,

3.5 is end-of-life, so I can't take any patches for it anymore, sorry.
In the future, take a look at the front page of www.kernel.org, it shows
what trees are still "alive" and which are end-of-life.

thanks,

greg k-h
