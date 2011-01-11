Return-Path: <linus.luessing@web.de>
Date: Tue, 11 Jan 2011 17:40:24 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110111164023.GA23062@Sellars>
References: <20110105115730.GB6723@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20110105115730.GB6723@Sellars>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] bitarray.c / packet-counting / window questions
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Jan 05, 2011 at 12:57:30PM +0100, Linus Lüssing wrote:
> And one more question for the TQ_LOCAL_WINDOW_SIZE, when i.e. I'd
> change that to a lower value, for instance 4, I'd have to set
> WORD_BIT_SIZE to (sizeof(unsigned long) / 2), right? Would that
> cause any trouble on the code side (and yeah, I know that this is
> causing unusable link quality measurements, but I wanted to reduce
> that to play a little with an exponentially weighted moving
> average on top of that).

Tried that, it's turning bit_packet_count() into an awesome pseudo
random number generator for [1,2,3,4] then, even when receiving
every sequence number, yaiy!
