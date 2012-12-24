Return-Path: <paukoning@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201212242237.07208.lindner_marek@yahoo.de>
References: <1353715332-4284-1-git-send-email-sven@narfation.org>
 <CANiGF9_=svx+W4Rhx8BL1NBv0H1aULeh71sX9YkMeR66OmmimA@mail.gmail.com>
 <201212242237.07208.lindner_marek@yahoo.de>
Date: Mon, 24 Dec 2012 16:36:03 +0100
Message-ID: <CANiGF98L_Ca20Eb+qVuX1126rWoeqQzOASshB7c2LQ-Fi7DiXA@mail.gmail.com>
From: Pau Koning <paukoning@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: Move soft-interface
 initialization to ndo_init
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, Sven Eckelmann <sven@narfation.org>

On Mon, Dec 24, 2012 at 3:37 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> On Monday, December 24, 2012 22:22:44 Pau Koning wrote:
>> On Sat, Nov 24, 2012 at 1:02 AM, Sven Eckelmann <sven@narfation.org> wrote:
>> > The initialization of an net_device object should be done in the
>> > init/constructor function and not from the outside after the
>> > register_netdevice was done to avoid race conditions.
>>
>> This patchset seems to be similar. Shouldn't it have been part of
>> 3.8-rc1 or got rejected? Neither of it happened in the last month
>
> It was discussed and a decision was made. Please read all mails in this thread
> before making noise.

What decision? I only see something about Patch 6 and Patch 7: Antonio
Quartulli doesn't want rtnetlink support in batman-adv. I don't see
any other statement about the rest of the patchset.
