Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 25 Oct 2017 15:15:31 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20171025131531.GI2750@otheros>
References: <CA+DjzFb8JV2opdLOTaPdm0wNXh95fvQSBcTdreUSmEQrVn5tKQ@mail.gmail.com>
 <20170816144705.GA11501@otheros>
 <mailman.4.1502895970.6668.b.a.t.m.a.n@lists.open-mesh.org>
 <20170816154159.GB11501@otheros>
 <CACXSwgp6X3NcAd7jv4K3rQBMmHwjwsYPZp5D88wOuBJ4yB=h9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACXSwgp6X3NcAd7jv4K3rQBMmHwjwsYPZp5D88wOuBJ4yB=h9A@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Manually Updating Translation table
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Kartikeswar Koppula <kartik@corenetdynamics.com>
Cc: "Kartikeswar Koppula via B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Hi Kartik,

On Wed, Oct 25, 2017 at 02:46:32PM +0200, Kartikeswar Koppula wrote:
> I checked the routes manually and it looks okay.

Could you share those? Next to "ip route show" the following tables
would be interesting, too:

$ ip address show
$ brctl show
$ batctl tg
$ batctl o
$ batctl n

Regards, Linus
