Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 20 May 2016 01:11:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160519231126.GH12565@otheros>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
 <20160519194553.GD12565@otheros> <20160519203049.GE12565@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160519203049.GE12565@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat by
 snooping received ip traffic
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

On Thu, May 19, 2016 at 10:30:49PM +0200, Linus Lüssing wrote:
> Or do dhcp-servers usually craft DHCPOFFERs
> in userspace within their daemon including the ethernet header?

Just noticed, they have to. The dhcp-server has to fill in the
ethernet destination as the kernel cannot provide it via ARP yet
- because the dhcp-client has no IP address yet :).
