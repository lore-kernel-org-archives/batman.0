Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 6 Aug 2016 06:42:44 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160806044244.GA13676@otheros>
References: <1468793741-4606-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1468793741-4606-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Don't allow zero and
 multicast sender address
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

On Mon, Jul 18, 2016 at 12:15:40AM +0200, Sven Eckelmann wrote:
> The routing checks are validating the sender mac address. They reject every
> sender mac address which is a broadcast. But they also have to reject
> zero-mac address and multicast mac addresses.

Initially I was a little shocked because there are legitimate
cases for zero-source MAC addresesses. But then I saw in the code
that you are talking about source MAC address of the outter
batman-adv frame :). Maybe that could be clarified in the commit
message?

For batadv_check_management_packet(), agreed, I guess much of the
protocol does rely on valid source addresses.

For data packets, I'm not quite sure, though. Could be interesting
to not restrict that now to still allow enhancements regarding
privacy, I think. And zero-source MAC addresses shouldn't harm
anything in the case of data packets, should they?
