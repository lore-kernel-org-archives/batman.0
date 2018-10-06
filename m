Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 6 Oct 2018 14:14:45 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20181006121445.GA1471@otheros>
References: <babe56e8-b12c-8236-7012-20bb91d400fa@blastwaveinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <babe56e8-b12c-8236-7012-20bb91d400fa@blastwaveinc.com>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. port to ESP32
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

Hi John,

On Mon, Oct 01, 2018 at 11:01:25AM -0700, John Gorkos wrote:
> I'm working on a port of the BATMAN-ADV protocol to FreeRTOS,
> specifically running on the ESP32 from EspressIF.

Awesome! I've never seen batman-adv running on such a device. And
it looks like you are already quite close to being the first one
accomplishing this.

> [...]
> Can someone explain to me why this might be occurring, and what I'm
> missing?  Currently, the code is doing two things:  sending a new OGM
> with an incrementing sequence number every 1000 ms,

> and re-broadcasting any received OGMs with a decremented TTL, modified TQ, and DirectLink
> flag set whenever it receives them (also every 1000 ms or so).

This sounds wrong. You should not rebroadcast any OGM. You should
only rebroadcast from the best candidate. I'm wondering whether
this could cause issues. Or are you testing with a single
EspressIF and a single Pi only for now?

If so, then it's probably more likely that just some flags or addresses
got mixed up. Would it be possible for you to share a tcpdump capture
from the Pi? You can also check with "batctl log" whether the Pi
seems to recognize the ESP32 as an originator.

Also, have you tested with two Pis and no EspressIF? Are Pis
themselves forming a mesh just fine for you? Just to outrule that
the issue is on the Pi side.

Regards, Linus
