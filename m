Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 10 Aug 2017 04:43:54 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170810024354.GM27539@otheros>
References: <49206786-169d-f793-5d48-f74dc8f4e838@televic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49206786-169d-f793-5d48-f74dc8f4e838@televic.com>
Subject: Re: [B.A.T.M.A.N.] No bandwidth over wired Batman mesh network
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

On Wed, Aug 09, 2017 at 08:31:43AM +0200, Mattias Vanhoutte wrote:
> So here I see a large drop of the TCP bandwidth by using batman 430 -> 125
> Mbit/s. Is this normal behavior?

Could be. Especially if you haven't increased the MTU on eth0 or
lowered the MTU on bat0 to avoid the batman-adv internal
frame fragmentation. See the warning displayed in "dmesg | grep
batman-adv" :-). 32bit ARM might not be fast enough to fragment
frames at a rate of 430Mbit/s.
