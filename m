Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: Mobile Vehicle Mesh Network
From: haas@yahoo.com
Date: Fri, 29 Jan 2021 22:26:13 -0000
Message-ID: <20210129222613.17252.74722@diktynna.open-mesh.org>
In-Reply-To: <CAMjFWEOpvMmedQw7sB-G1f9pMMo6ymhZemVy07Y0UeUN+EPU1w@mail.gmail.com>
References: <CAMjFWEOpvMmedQw7sB-G1f9pMMo6ymhZemVy07Y0UeUN+EPU1w@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

Something like Maxwell openwrt batman nodes would work well... 
https://www.crowdsupply.com/andy-haas/maxwell
They would be fixed in location. No mesh does great when the nodes are moving around rapidly. The response / reconfiguration time is on the order of a minute or so, not fast. 
The robots would reach have an access point that gets internet from the static mesh wifi and provides local wifi and ethernet to the robot clients. 

If the robot access point could not connect to a static mesh node, it could connect to another robot's wifi, but that sounds complicated.

