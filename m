Return-Path: <germano.massullo@gmail.com>
From: Germano Massullo <germano.massullo@gmail.com>
Message-ID: <5609712B.6020308@gmail.com>
Date: Mon, 28 Sep 2015 18:56:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Suggestions to get extended jsondoc alfred output
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

I created three Fedora virtual machines to get some alfred jsondoc
format output. I followed [1] and [2] but I edited some commands because
virtual machines obviously do not own wireless network interfaces. Since
it is the first time I use batman+alfred I want to show you the entire
list of commands (that have been runned on all the virtual machines.) I
used before asking my question

# ip link set dev enp0s3 mtu 1532
# batctl if add enp0s3
# ip link set bat0 up
# alfred -i enp0s3 -m

The    # ip addr     of all virtual machines is [3]
Then I opened a new console

# cat /etc/hostname | alfred -s 65
# alfred -r 65
then I got [4] as the Examples paragraph [2] suggested
# batadv-vis --format=3Djsondoc
and I got [5]

Question: do you have any suggestion how I can extend the jsondoc
output, to get an output similar to [6]?

Thank you for your time


[1] http://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide
[2] http://downloads.open-mesh.org/batman/manpages/alfred.8.html
[3] http://i.imgur.com/IR9pSJg.jpg
[4] http://i.imgur.com/hEP4oV7.jpg
[5] http://i.imgur.com/Tb1hRHl.jpg
[6]
https://github.com/ninuxorg/netdiff/blob/master/tests/static/batman-1%2B1=
=2Ejson

