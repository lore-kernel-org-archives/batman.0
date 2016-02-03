Return-Path: <jwboyer@gmail.com>
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <1454514090.3083.8.camel@sipsolutions.net>
References: <CA+5PVA4HVjsEw+j+HMDzO0gnQb4xTRwbAu4H2do3MU41QWvOvw@mail.gmail.com>
 <CA+5PVA55MSh-kKCLGcUV2uMkx+SqwuXY0WbONS8Q0mxh4+_gcw@mail.gmail.com>
 <1454514090.3083.8.camel@sipsolutions.net>
Date: Wed, 3 Feb 2016 10:49:14 -0500
Message-ID: <CA+5PVA61Aim=bnftFDkS7PNQ5gATP6jkBUYQob0erqgfYmZA-w@mail.gmail.com>
From: Josh Boyer <jwboyer@fedoraproject.org>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] ibss.c backtrace when batman-adv adds wireless
	interface
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, netdev <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@codeaurora.org>, Larry Finger <Larry.Finger@lwfinger.net>

On Wed, Feb 3, 2016 at 10:41 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2016-02-03 at 10:26 -0500, Josh Boyer wrote:
>> On Wed, Feb 3, 2016 at 10:24 AM, Josh Boyer <jwboyer@fedoraproject.or
>> g> wrote:
>> > Hi All,
>> >
>> > We've had a user report the backtrace below when loading batman-adv
>> > on
>> > his machine.  It looks like the cfg80211 layer is complaining about
>> > a
>> > null bss returned, but I cannot tell if the rtlwifi driver or
>> > batman-adv is in error here.
>> >
>> > Thoughts?
>>
>> Sorry, forgot to include the link to the actual bug report:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1304428
>>
>> Reporter says this is new with 4.3.y and did not happen on e.g.
>> 4.2.8.
>>
>
> AFAICT this should be a driver (or perhaps mac80211) issue, but I don't
> see any information about the driver used.

The backtrace has all the modules loaded included in it.  rtlwifi is
listed there and it's the only wireless driver in use (rtl8192cu
specifically via USB).

josh
