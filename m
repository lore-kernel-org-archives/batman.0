Return-Path: <ordex@autistici.org>
Date: Fri, 25 Nov 2011 12:04:44 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111125110443.GB17321@autistici.org>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-5-git-send-email-ordex@autistici.org>
	<20111125083125.GF6836@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20111125083125.GF6836@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 4/7] batman-adv: Distributed ARP Table
 - add ARP parsing functions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Nov 25, 2011 at 09:31:25AM +0100, Andrew Lunn wrote:
> Do we have any idea how many people run vlans over B.A.T.M.A.N? It
> would not be too hard to skip over the VLAN tag if there is one to see
> if it is an ARP message inside.

Actually I don't have any idea about that, but I think there is plenty
of those out there.

However: Yes you are right. I discussed this with Simon several times, but since
I have never dealt with the VLAN before, I postponed this "feature" (ok, it's
a very small one) to a later patch..

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara ☭
