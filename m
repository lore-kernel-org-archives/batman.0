Return-Path: <gui@altermundi.net>
In-Reply-To: <20130908215344.GA7824@pandem0nium>
References: <1378585186-7970-1-git-send-email-nils@nilsschneider.net>
 <20130907203207.GN1570@ritirata.org> <87hadw1hbs.wl%nils@nilsschneider.net>
 <201309081039.23458.lindner_marek@yahoo.de>
 <87ppsj66pn.wl%nils@nilsschneider.net> <20130908215344.GA7824@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
From: Gui Iribarren <gui@altermundi.net>
Date: Sun, 08 Sep 2013 20:40:35 -0300
Message-ID: <ace6651d-37eb-42d5-90d1-f449319b87e8@email.android.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: output valid JSON
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

I'm already turning your output into proper json, but inside my lua script. So getting json out of alfred would simplify things :)
I.e.: +1 and thanks for the patch!

Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de> wrote:
>Hey Nils,
>
>thanks for your patch!
>
>On Sun, Sep 08, 2013 at 10:47:00AM +0200, Nils Schneider wrote:
>> The current output format of alfred -r looks like this:
>> 
>> { "fe:f1:00:00:01:01", "OpenWRT-node-1\x0a" },
>> { "fe:f1:00:00:02:01", "OpenWRT-node-2\x0a" },
>> { "fe:f1:00:00:03:01", "OpenWRT-node-3\x0a" },
>> 
>> It's not clear how one should parse this as there is no documentation
>> except the source code.
>
>The output was first designed for debugging and scripts who should
>parse
>that (binary programs like vis may access the unix sockets directly).
>
>> 
>> With my patch, it'll look like this:
>> 
>> {
>>   "fe:f1:00:00:01:01": "OpenWRT-node-1\u000a",
>>   "fe:f1:00:00:02:01": "OpenWRT-node-2\u000a",
>>   "fe:f1:00:00:03:01": "OpenWRT-node-3\u000a"
>> }
>> 
>> This is JSOΝ which is well documented and thus can be parsed
>> easily. It's a dictionary with the node's ID as the key and the data
>> as value.
>
>I think your suggestion/patch is a good idea, it will result in a more
>general format. I'd like to ask you to send your patch again with a
>revised commit message (e.g. add your examples from this mail and a
>short explanation why the old format was bad, and why JSON is better).
>
>I'd then would like to wait for approx. 1 week to gather comments from
>people who already parse the old format already (Guido?), and if there
>are
>no objections merge it.
>
>Thanks!
>	Simon
>> 
>> At Sun, 8 Sep 2013 10:39:23 +0800,
>> Marek Lindner wrote:
>> > 
>> > On Sunday, September 08, 2013 04:56:39 Nils Schneider wrote:
>> > > The current output format isn't really broken, just tricky to
>parse.
>> > > I decided to make it valid JSOΝ as it was already pretty close.
>This
>> > > allows parsing with virtually any programming language.
>> > 
>> > Please be more specific about what was broken and how your fix
>addresses the 
>> > problem. An example would be nice too.
>> > 
>> > Cheers,
>> > Marek

