Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 29 Mar 2016 02:02:19 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160329000219.GB4528@otheros>
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
> Node A cannot know, whether you have scenario 1 or 2.

But an ethernet driver or mac80211 with AP/STA interfaces
(without ap-isolation) could. Or tinc with forwarding enabled
would know. All these can be pretty sure that things are
transitive and could set a TRANSITIVE flag quite safely.

Any other interface type, driver etc. would leave the
TRANSITIVE flag unset by default to be on the safe side.
