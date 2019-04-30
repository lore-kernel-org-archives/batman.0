Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 30 Apr 2019 18:07:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce "noflood" broadcast
 flood prevention option
Message-ID: <20190430160726.GD5267@otheros>
References: <20190426171231.18156-1-linus.luessing@c0d3.blue>
 <2852684.HY4pDEyiBM@sven-edge>
 <cb27fa9e-c7d2-db51-6f47-c717612b82af@darmstadt.freifunk.net>
 <20190430160121.GC5267@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190430160121.GC5267@otheros>
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

On Tue, Apr 30, 2019 at 06:01:21PM +0200, Linus Lüssing wrote:
> So while that was the main use-case for me before the discussions
> we had last year on how to improve DAT, it's now more a minor one
> for me. Though it would still be nice to have / work towards a zero-broadcast
> mesh as RFC7772 for instance explains that frequent broadcasts
> have a quite significant impact on battery power for small, mobile
> devices. And the noflood option would be a quick and easy option
> for us for now to achieve this for ARP and other packet types.
> 
> [0]: https://tools.ietf.org/html/rfc7772

More precisely, RFC7772 section 4 has some estimates regarding power
cost for having frequent broadcast packets.
