Return-Path: <roland.volkmann@t-online.de>
References: <56F5AF2F.6060904@t-online.de> <6005839.o5jWIFZeG0@voltaire>
 <56F934F9.5000508@t-online.de> <11401348.Kx9RpUz81r@voltaire>
 <20160328191128.GA2772@otheros> <56F99FCD.5040704@t-online.de>
 <20160329000219.GB4528@otheros>
From: Roland Volkmann <roland.volkmann@t-online.de>
Message-ID: <56FA22F9.9060205@t-online.de>
Date: Tue, 29 Mar 2016 08:38:49 +0200
MIME-Version: 1.0
In-Reply-To: <20160329000219.GB4528@otheros>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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

Linus Lüssing schrieb am 29.03.2016 um 02:02:
> On Mon, Mar 28, 2016 at 11:19:09PM +0200, Roland Volkmann wrote:
>> Node A cannot know, whether you have scenario 1 or 2.
> But an ethernet driver or mac80211 with AP/STA interfaces
> (without ap-isolation) could. Or tinc with forwarding enabled
> would know. All these can be pretty sure that things are
> transitive and could set a TRANSITIVE flag quite safely.
>
> Any other interface type, driver etc. would leave the
> TRANSITIVE flag unset by default to be on the safe side.

Thank you for your explanations. Indeed covering most cases 
automatically but still have a knob for very special environments is a 
very good idea. I'm looking forward having this available - hopefully in 
short term.

Best regards,
Roland.

