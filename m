Return-Path: <keith.chew@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20151022005325.GB930@lunn.ch>
References: <CAKaWdxbrS90fbV4if4ZhRYtdL-neikMc4iVb_EtowJf8M=9dvg@mail.gmail.com>
 <20151022005325.GB930@lunn.ch>
Date: Thu, 22 Oct 2015 14:03:19 +1300
Message-ID: <CAKaWdxYsHwOGu6YXLr6APgwwBP-xdg3DmFD63z6ehj=sv4PCUw@mail.gmail.com>
From: Keith Chew <keith.chew@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Alfred GPS higher update rate
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Andrew

> You need to change more than alfred-gpsd. The core alfred server does
> updates every 10 seconds. You need to change ALFRED_INTERVAL so that
> it will propagate GPS data faster. If you want 200ms, i doubt such a
> change would be accepted back to the core code. So you probably need
> to add a command line option to allow setting this interval.
>

Yes, I see the option and will have go at changing it for testing.

> alfred-gpsd will also need some changes. It currently updated the
> information in alfred every 2 seconds. You will need to modify this as
> well.
>

Ah, I did not know about this one, thank you very much for the
pointer, will also update this.

> When i wrote the alfred-gpsd code, i was not particularly interested
> in fast updates. So you might need to change the architecture a
> little. In particular, i knew gpsd was giving fixes much faster than
> alfred would distribute them, so i didn't tell alfred about every
> change. You might need this.

This is not a problem, I can look into this. I am worried about the
5Hz update rate, would the alfred/batman network layer be able to
handle the data. I was thinking of writing an app at a higher level on
the drone to broadcast the data to each other, but since alfred
conceptually already does what I want (except at a lower rate), my
plan was to first try it.

Thanks again for your help, much appreciated.

Regards
Keith
