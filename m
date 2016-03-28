Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 29 Mar 2016 01:52:47 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160328235247.GA4528@otheros>
References: <56F5AF2F.6060904@t-online.de> <6005839.o5jWIFZeG0@voltaire>
 <56F934F9.5000508@t-online.de> <11401348.Kx9RpUz81r@voltaire>
 <20160328191128.GA2772@otheros> <56F99FCD.5040704@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56F99FCD.5040704@t-online.de>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

On Mon, Mar 28, 2016 at 11:19:09PM +0200, Roland Volkmann wrote:
> But I'm not sure it is possible to detect automatically whether rebroadcast
> are necessary or not in all cases.

Of course not. But I think Marek's suggestion is a good
compromise between the completely manual approach on the one hand
and detecting everything automagically in batman-adv on the other.

At least this approach would cover everything we care about for
current Freifunk setups for now and many more. Without the user
being able to misconfigure something that easily. (usually a user
would not set a TRANSITIVE flag on the interface, but e.g. drivers
and applications creating the interface would)
