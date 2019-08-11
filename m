Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 12 Aug 2019 00:07:56 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [RFC] batman-adv: ELP - use wifi tx bitrate as fallback throughput
Message-ID: <20190811220756.GL2407@otheros>
References: <20190811130705.4544-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190811130705.4544-1-mareklindner@neomailbox.ch>
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

On Sun, Aug 11, 2019 at 09:07:05PM +0800, Marek Lindner wrote:
> From: René Treffer <treffer@measite.de>
> 
> Some wifi drivers (e.g. ath10k) provide per-station rx/tx values but no
> estimated throughput. Setting a better estimate than the default 1 MBit
> makes these devices work well with B.A.T.M.A.N. V.
> 
> Signed-off-by: René Treffer <treffer@measite.de>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---

In general, I like this approach. It's simple and roughly matches
our conservative assumptions we used for broadcast packets, too.
That is 3x transmissions per packet.

Lukonin's approach sounds more accurate in theory. But should
probably have a bit more testing and reviewable test results due to
it's slightly higher complexity.

Regards, Linus
